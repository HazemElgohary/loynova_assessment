import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loynova_assessment/core/di/injection.dart';
import 'package:loynova_assessment/features/transfer_points/domain/repositories/transfer_repository.dart';
import 'package:loynova_assessment/features/wallet/data/dtos/transfer_request_dto.dart';

import '../manager/transfer_bloc.dart';
import '../manager/transfer_events.dart';
import '../manager/transfer_state.dart';

class TransferPointsScreen extends StatefulWidget {
  final int availableBalance;

  const TransferPointsScreen({super.key, required this.availableBalance});

  @override
  State<TransferPointsScreen> createState() => _TransferPointsScreenState();
}

class _TransferPointsScreenState extends State<TransferPointsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _recipientController = TextEditingController();
  final _pointsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransferBloc(getIt<TransferRepository>()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Transfer Points')),
        body: BlocConsumer<TransferBloc, TransferState>(
          listener: (context, state) {
            if (state is TransferSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Transfer Successful')),
              );
              context.pop(state.result);
            } else if (state is TransferError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _recipientController,
                      decoration: const InputDecoration(labelText: 'Recipient'),
                      validator: (value) =>
                          value!.isEmpty ? 'Enter recipient' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _pointsController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Points'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter points';
                        }
                        final points = int.tryParse(value) ?? 0;
                        if (points <= 0) return 'Invalid amount';
                        if (points > widget.availableBalance) {
                          return 'Insufficient balance';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: state is TransferLoading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                context.read<TransferBloc>().add(
                                  SubmitTransfer(
                                    TransferRequestDto(
                                      recipient: _recipientController.text,
                                      points: int.parse(_pointsController.text),
                                    ),
                                  ),
                                );
                              }
                            },
                      child: state is TransferLoading
                          ? const CircularProgressIndicator()
                          : const Text('Send'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
