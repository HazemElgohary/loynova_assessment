import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loynova_assessment/core/di/injection.dart';
import 'package:loynova_assessment/features/transfer_points/domain/repositories/transfer_repository.dart';
import 'package:loynova_assessment/features/wallet/data/dtos/transfer_request_dto.dart';

import '../manager/transfer_bloc.dart';
import '../manager/transfer_events.dart';
import '../manager/transfer_state.dart';

class TransferPointsScreen extends StatelessWidget {
  final int availableBalance;
  const TransferPointsScreen({super.key, required this.availableBalance});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransferBloc(
        repository: getIt<TransferRepository>(),
        availableBalance: availableBalance,
      ),
      child: Scaffold(
        appBar: AppBar(title: const Text('Transfer Points')),
        body: BlocConsumer<TransferBloc, TransferState>(
          listener: (context, state) {
            if (state.result != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Transfer Successful')),
              );
              context.pop(state.result);
            }
            if (state.error != null) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.error ?? '')));
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    onChanged: (v) =>
                        context.read<TransferBloc>().add(RecipientChanged(v)),
                    decoration: InputDecoration(
                      labelText: 'Recipient',
                      errorText: state.recipient.error,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    onChanged: (v) =>
                        context.read<TransferBloc>().add(PointsChanged(v)),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                    ],
                    decoration: InputDecoration(
                      labelText: 'Points',
                      errorText: state.points.error,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    onChanged: (v) =>
                        context.read<TransferBloc>().add(NoteChanged(v)),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    maxLength: 150,
                    decoration: InputDecoration(
                      labelText: 'Note',
                      errorText: state.note.error,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: state.isFormValid && !state.isSubmitting
                          ? () => context.read<TransferBloc>().add(
                              const SubmitTransfer(),
                            )
                          : null,
                      child: state.isSubmitting
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Submit Transfer'),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
