// Copyright (c) 2011-2014 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef CATRA_QT_CATRAADDRESSVALIDATOR_H
#define CATRA_QT_CATRAADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class CatraAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit CatraAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

/** Catra address widget validator, checks for a valid catra address.
 */
class CatraAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit CatraAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

#endif // CATRA_QT_CATRAADDRESSVALIDATOR_H
