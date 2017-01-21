Return-Path: <linux-kernel-owner@vger.kernel.org>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/5] s390/pci: Fine-tuning for three function implementations
Message-ID: <f2233afd-bc54-0697-0709-9577e96fc6a6@users.sourceforge.net>
Date: Sat, 21 Jan 2017 19:09:05 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, =?UTF-8?Q?Gerald_Sch=c3=a4fer?= <gerald.schaefer@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 21 Jan 2017 18:58:18 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (5):
  Return directly after a failed parameter validation in clp_normal_command()
  Return directly after a failed clp_alloc_block() in clp_normal_command()
  Move three assignments for the variable "rc" in clp_normal_command()
  Move an assignment for the variable "ret" in s390_pci_mmio_write()
  Move two assignments for the variable "ret" in get_pfn()

 arch/s390/pci/pci_clp.c  | 20 +++++++++-----------
 arch/s390/pci/pci_mmio.c | 19 ++++++++++---------
 2 files changed, 19 insertions(+), 20 deletions(-)

-- 
2.11.0
