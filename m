Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [PATCH 6/6] s390x: Mark archrandom.h functions __must_check
References: <20191028210559.8289-1-rth@twiddle.net>
 <20191028210559.8289-7-rth@twiddle.net>
 <935cf73a-d06c-365d-131a-23dcb350ba17@linux.ibm.com>
 <cd6b5b8c-77f0-ad7e-702a-27e5a929ca54@linaro.org>
From: Harald Freudenberger <freude@linux.ibm.com>
Date: Wed, 30 Oct 2019 08:56:07 +0100
MIME-Version: 1.0
In-Reply-To: <cd6b5b8c-77f0-ad7e-702a-27e5a929ca54@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <95aa7fd3-5e80-f11b-3f74-42628f7dfba4@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>, linux-arch@vger.kernel.org
Cc: x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On 29.10.19 14:18, Richard Henderson wrote:
> On 10/29/19 8:26 AM, Harald Freudenberger wrote:
>> Fine with me, Thanks, reviewed, build and tested.
>> You may add my reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
>> However, will this go into the kernel tree via crypto or s390 subsystem ?
> That's an excellent question.
>
> As an API decision, perhaps going via crypto makes more sense,
> but none of the patches are dependent on one another, so they
> could go through separate architecture trees.
>
> It has been a long time since I have done much kernel work;
> I'm open to suggestions on the subject.
>
>
> r~
Since the change needs to be done in include/linux/random.h
and in parallel with all the arch files in arch/xxx/include/asm/archrandom.h
it should go in one shot. I'd suggest to post the patch series to linux-crypto
and let Herbert Xu handle this.
