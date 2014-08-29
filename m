Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <5400694C.4040303@de.ibm.com>
Date: Fri, 29 Aug 2014 13:51:40 +0200
From: Christian Borntraeger <borntraeger@de.ibm.com>
MIME-Version: 1.0
Subject: Re: WARNING: at kernel/workqueue.c:845
References: <54005AFB.2010604@de.ibm.com>
In-Reply-To: <54005AFB.2010604@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On 29/08/14 12:50, Christian Borntraeger wrote:
> Tejun,
> 
> with kvm/next (pretty close to 3.17-rc1) as KVM guest I get the following warning in one of my stress tests:

Turns out that it happens when I shutdown the guest via an sclp quiesce interrupt (wired to ctrl-alt-delete)
and it also happens with 3.16, just less often. So I will some other places first.

Christian
