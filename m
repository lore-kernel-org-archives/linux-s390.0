Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20110908132609.177038405@linux.vnet.ibm.com>
Date: Thu, 08 Sep 2011 15:26:09 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [RFC][patch 0/2] kdump: Allow removal of page tables for crashkernel memory
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: vgoyal@redhat.com
Cc: ebiederm@xmission.com, mahesh@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hello Vivek,

I am back from vacation. We had one topic left that we didn't finish last time:
The removal of page tables for the crashkernel memory to protect the
loaded kdump kernel.

This patch series implements a new proposal for that:
[1] kdump: Add infrastructure for unmapping crashkernel memory
[2] s390: Add architecture code for unmapping crashkernel memory

The patches apply on the last kdump patch series that I sent.

Michael
