Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 0/2] 390/qeth: Fine-tuning for qeth_core_set_online()
References: <566ABCD9.1060404@users.sourceforge.net>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <5688F13A.70601@users.sourceforge.net>
Date: Sun, 3 Jan 2016 11:00:26 +0100
MIME-Version: 1.0
In-Reply-To: <566ABCD9.1060404@users.sourceforge.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-ID: <linux-s390.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 3 Jan 2016 10:56:45 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an unnecessary variable initialisation
  Refactoring

 drivers/s390/net/qeth_core_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.6.3
