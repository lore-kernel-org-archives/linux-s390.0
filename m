Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36619 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388227AbfJ2NSz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 29 Oct 2019 09:18:55 -0400
Received: by mail-pl1-f194.google.com with SMTP id g9so6998848plp.3
        for <linux-s390@vger.kernel.org>; Tue, 29 Oct 2019 06:18:55 -0700 (PDT)
Subject: Re: [PATCH 6/6] s390x: Mark archrandom.h functions __must_check
References: <20191028210559.8289-1-rth@twiddle.net>
 <20191028210559.8289-7-rth@twiddle.net>
 <935cf73a-d06c-365d-131a-23dcb350ba17@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cd6b5b8c-77f0-ad7e-702a-27e5a929ca54@linaro.org>
Date: Tue, 29 Oct 2019 14:18:33 +0100
MIME-Version: 1.0
In-Reply-To: <935cf73a-d06c-365d-131a-23dcb350ba17@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Harald Freudenberger <freude@linux.ibm.com>, linux-arch@vger.kernel.org
Cc: x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On 10/29/19 8:26 AM, Harald Freudenberger wrote:
> Fine with me, Thanks, reviewed, build and tested.
> You may add my reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
> However, will this go into the kernel tree via crypto or s390 subsystem ?

That's an excellent question.

As an API decision, perhaps going via crypto makes more sense,
but none of the patches are dependent on one another, so they
could go through separate architecture trees.

It has been a long time since I have done much kernel work;
I'm open to suggestions on the subject.


r~
