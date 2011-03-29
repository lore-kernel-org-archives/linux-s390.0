Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20110329124825.027309213@linux.vnet.ibm.com>
Date: Tue, 29 Mar 2011 14:48:25 +0200
From: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Subject: [patch 0/1] Do not unregister_cpu_notifier in case of wrong state 
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: robert.richter@amd.com
Cc: mingo@elte.hu, oprofile-list@lists.sf.net, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Heinz Graalfs <graalfs@linux.vnet.ibm.com>

This patch avoids calling unregister_cpu_notifier() in case
hwsampler_shutdown() is invoked in wrong state. 
