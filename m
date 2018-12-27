Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: 4.19.5 and later has tons of false messages "BUG: non-zero
 pgtables_bytes on freeing mm: -16384"
Date: Thu, 27 Dec 2018 10:13:01 +0100
MIME-Version: 1.0
Content-Language: en-US
Message-Id: <4e58571e-1991-4a70-7012-ff9dd76afee3@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, stable@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-ID: <linux-s390.vger.kernel.org>

Martin,

Right now you get a message 
"BUG: non-zero pgtables_bytes on freeing mm: -16384"
for EVERY process that exits in 4.19.5 and later.

bisect points to 
commit 4136161d676a93fc8df6bdb80d720c15522d6c24
Author: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date:   Mon Oct 15 11:09:16 2018 +0200

    s390/mm: fix mis-accounting of pgtable_bytes
    
    [ Upstream commit e12e4044aede97974f2222eb7f0ed726a5179a32 ]

Turns out that this patch requires several dependencies so the autoselection of this
patch was missing that. 

Can we either revert this patch or add the dependencies?

Christian
