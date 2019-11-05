Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45772 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390258AbfKEReF (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 5 Nov 2019 12:34:05 -0500
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 90A4FC057F23
        for <linux-s390@vger.kernel.org>; Tue,  5 Nov 2019 17:34:04 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id f8so9817538wrq.6
        for <linux-s390@vger.kernel.org>; Tue, 05 Nov 2019 09:34:04 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [kvm-unit-tests PATCH 0/2] s390x: Improve architectural compliance for diag308
Date: Tue, 5 Nov 2019 18:34:01 +0100
Message-Id: <70BDB5DE-489D-4718-B6C2-0EABD89414D2@redhat.com>
References: <20191105162828.2490-1-frankja@linux.ibm.com>
In-Reply-To: <20191105162828.2490-1-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com



> Am 05.11.2019 um 17:29 schrieb Janosch Frank <frankja@linux.ibm.com>:
> 
> ﻿When testing diag308 subcodes 0/1 on lpar with virtual mem set up, I
> experienced spec PGMs and addressing PGMs due to the tests not setting
> short psw bit 12 and leaving the DAT bit on.
> 
> The problem was not found under KVM/QEMU, because Qemu just ignores
> all cpu mask bits... I'm working on a fix for that too.
> 

I don‘t have access to documentation. Is what LPAR does documented behavior or is this completely undocumented and therefore undefined behavior? Then we should remove these test cases completely instead.

> Janosch Frank (2):
>  s390x: Add CR save area
>  s390x: Remove DAT and add short indication psw bits on diag308 reset
> 
> lib/s390x/asm-offsets.c  |  3 ++-
> lib/s390x/asm/arch_def.h |  5 +++--
> lib/s390x/interrupt.c    |  4 ++--
> lib/s390x/smp.c          |  2 +-
> s390x/cstart64.S         | 29 ++++++++++++++++++++---------
> 5 files changed, 28 insertions(+), 15 deletions(-)
> 
> -- 
> 2.20.1
> 
