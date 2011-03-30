Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20110330080637.110679740@linux.vnet.ibm.com>
Date: Wed, 30 Mar 2011 10:06:37 +0200
From: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Subject: v2 [patch 0/1] hwsampler_shutdown
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: robert.richter@amd.com
Cc: mingo@elte.hu, oprofile-list@lists.sf.net, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hello Robert, 

yes, and you are right we should reset hws_state to zero.

Heinz
