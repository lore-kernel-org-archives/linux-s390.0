Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20110215180212.334742128@linux.vnet.ibm.com>
Date: Tue, 15 Feb 2011 19:02:12 +0100
From: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Subject: [patch 0/2] delta patch - s390 hw sampling rework on comments as of Feb 14th
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: robert.richter@amd.com
Cc: mingo@elte.hu, oprofile-list@lists.sf.net, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Robert,

here is the first version of the rework for your comments as of February 14th.

   1. I merged hwsampler_files.c contents into init.c
   2. I added a struct as you proposed.

   It is not clear to me how you want me to merge the static functions.

   One possibility I'm seeing is to merge log_sample, op_add_code, and op_add_sample?

Heinz
