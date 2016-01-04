Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: 390/qeth: Refactoring for qeth_core_set_online()
References: <566ABCD9.1060404@users.sourceforge.net>
 <5688F13A.70601@users.sourceforge.net>
 <5688F1D0.3090502@users.sourceforge.net> <20160104113046.GE4179@osiris>
 <568A6F4A.1000206@users.sourceforge.net> <20160104140447.GG4179@osiris>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <568A7D61.90703@users.sourceforge.net>
Date: Mon, 4 Jan 2016 15:10:41 +0100
MIME-Version: 1.0
In-Reply-To: <20160104140447.GG4179@osiris>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-ID: <linux-s390.vger.kernel.org>

> In this case the function body is very small
> so I don't see any benefit at all.

Do you care for fine-tuning of variable placement occasionally?

Regards,
Markus
