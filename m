Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20110915090440.063421605@linux.vnet.ibm.com>
Date: Thu, 15 Sep 2011 11:04:40 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [patch v3 0/2] kdump: Allow removal of page tables for crashkernel memory
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: vgoyal@redhat.com, akpm@linux-foundation.org
Cc: ebiederm@xmission.com, mahesh@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hello Vivek, Andrew, Martin

Here the version 3 patch series for the removal of page tables for the
crashkernel memory:

[1] kdump: Add infrastructure for unmapping crashkernel memory
[2] s390: Add architecture code for unmapping crashkernel memory

Changes to version 2: Use resource_size()

The patches apply on top of the last kdump patch series that I sent.

I would suggest that Martin sends the patches together with the other s390
kdump patches in the next merge window.

Michael
