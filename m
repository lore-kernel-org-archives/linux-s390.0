Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE04736B939;
	Thu,  1 Oct 2026 04:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790829693; cv=none; b=BrQpEAiCJ87BvpClWee0kBYLIdPFRCZ/fopmfg6DkrcQ8LhfMrJwyvNutOl9xxOix5sNjPE5QptMQbk7tKiKK2n1d5KXWw/IJvRnr30mO7RgZna9ZML3phFZiB5B3Nwxx+3SmY6xSjYyGrRBuss8BouRxpp5qFLHhp9G9E+IdtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790829693; c=relaxed/simple;
	bh=LJabXzDr8Pqmi2JYmBKjyWjaEcW0q9oUv6Q7p35WK6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=elF3HaCwhLb7wVhlIMarygE+Ubslhmql/+6e36/eVwgfKMfgSOVL6mbO8WTXxdRDo3laYlrJqE0aUaPohFfEGFT/2WaB+Fo657Jbg8it0F43QPzKb52B8WdEHkj8yhsPLQFzZjaLf6RA62QSkWyx3g96emitl9GeDKx5csJVCIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bq0nZkKW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bq0nZkKW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96EF1F000FF;
	Thu,  1 Oct 2026 04:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790829691;
	bh=tVU5xB7+vpzEDdoS9i3GNs5XYI1dWTYZUYdxVIutOtM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Bq0nZkKWMqWIxU4tIv4zapeOdCpnHz5b/zR/btuwhOI6yqWhkNa16ZLAdV0XAonaE
	 LT/7g8b0EEn8q6WkaYSXcge2H8Yc3IFapoddC+KtKRElzzzS2tCykxpi6k5aZA9kay
	 7Bx2fP9pScRcEmAWGN5VHfJ7AF5BwdkPUQT7ytyICmEnBPU0xblgkviAuLC9gCD0Mc
	 1wW64Qj4Bi6OFUgghHfnyrW6ZOr1ms95vNMMwVa/6E/AhGbiTu69p6opZ+oOc4sLrS
	 iIWKzWRMviz1dpodiBtpGvwGIBrsrPpmtw65JP7qKlykYyEAPSVgsAOV08268AC+o8
	 rWTxHJHwYW1TQ==
Message-ID: <ede392d7-3104-4a0f-9fa1-99b22552dcd6@kernel.org>
Date: Thu, 1 Oct 2026 06:41:20 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] random: vDSO: Avoid call to memset() when zeroing
 reserved in __cvdso_getrandom_data()
To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, Vincenzo Frascino
 <vincenzo.frascino@arm.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 llvm@lists.linux.dev
References: <CAKwvOdmuvn0LZkYEsH84hnOGTYhTtzuWs3wMARtWdTeL6dD9sA@mail.gmail.com>
 <CAKwvOdnxKVpn=nAFaqP+9PTx4PqgHsUVWv6e60Pcr29W_eZrpQ@mail.gmail.com>
 <CAKwvOdmNZL3eFvV3v77GXDzL+XLgz+BT9TA=my0yTnbsHqVeSg@mail.gmail.com>
 <areYMjNcaqe86ds4@zx2c4.com>
 <9d1c338b-368f-4ea2-a12e-c28d49adff5e@kernel.org>
 <are6s5e6On3hpD3M@zx2c4.com>
 <CAKwvOd=BrMfFT88jsvBPhh383qqk5G+J07CsofNu0MVkziyhCg@mail.gmail.com>
 <20260930133813.GA3142230@ax162> <ar0a4b9CjL2YHCkY@zx2c4.com>
 <ar0gTS71qxnx9AkW@zx2c4.com> <20260930151337.GD3142230@ax162>
 <CAHmME9pA+AntJ6hWoFYpTVjh-NUSd0ZGXp5XiUuhQcq3HjQT3g@mail.gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <CAHmME9pA+AntJ6hWoFYpTVjh-NUSd0ZGXp5XiUuhQcq3HjQT3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Le 30/09/2026 à 17:16, Jason A. Donenfeld a écrit :
> On Wed, Sep 30, 2026 at 5:13 PM Nathan Chancellor <nathan@kernel.org> wrote:
>>
>> On Wed, Sep 30, 2026 at 04:44:29PM +0200, Jason A. Donenfeld wrote:
>>> Nathan, would this be okay with you?
>>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.zx2c4.com%2Flinux-rng%2Fcommit%2F%3Fid%3Dd216701724b7d8209ff42150658ad5c712bdb503&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C8f69935bffb344bf0ddc08df1f05e358%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639263782324080837%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=BA7Fyr0%2FynggvBnR%2FpiCvNCQHtNBagqvSb0i11AvoLU%3D&reserved=0
>>
>> Can you stick
>>
>>    Cc: stable@vger.kernel.org # v6.12+
>>    Closes: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FClangBuiltLinux%2Flinux%2Fissues%2F2183&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C8f69935bffb344bf0ddc08df1f05e358%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639263782324110679%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=6C8%2FAEQoh%2B8pfgfYQkL7qf5Ue%2F5sAGtfqRptzsSG0CM%3D&reserved=0
>>
>> on that? Otherwise, looks good to me, that's basically what I had for my
>> v3 locally.
> 
> Sure, done. Also removed the now-unused array_size.h include.

I'm still very sceptic with this patch. You are degrading the behaviour 
with GCC for a problem with CLANG. Why ?

Before the patch, with both GCC 13 and GCC 16 on powerpc32 I get a 
pretty standard optimised loop that clears words 4 by 4 (with auto 
increment of pointer) which is the most optimal on powerpc:

  3f0:	39 00 00 0c 	li      r8,12
  3f4:	35 08 ff fc 	addic.  r8,r8,-4
  3f8:	91 49 00 04 	stw     r10,4(r9)
  3fc:	91 49 00 08 	stw     r10,8(r9)
  400:	91 49 00 0c 	stw     r10,12(r9)
  404:	95 49 00 10 	stwu    r10,16(r9)
  408:	40 82 ff ec 	bne     3f4 <__c_kernel_getrandom+0x3f4>

With the patch,

With GCC 13 I get a very suboptimal loop copying bytes one by one

  3d8:	39 40 00 34 	li      r10,52
...
  3e4:	39 20 00 00 	li      r9,0
  3e8:	7d 49 03 a6 	mtctr   r10
  3ec:	9d 3e 00 01 	stbu    r9,1(r30)
  3f0:	42 00 ff fc 	bdnz    3ec <__c_kernel_getrandom+0x3ec>

With GCC 16 I get something a bit better but not as good as before, it 
is a loop clearing words only one by one and incrementing pointer with 
an additional insn instead of using auto-increment instruction stwu.

  3e0:	39 40 00 0d 	li      r10,13
...
  3f0:	7d 49 03 a6 	mtctr   r10
  3f4:	91 3f 00 00 	stw     r9,0(r31)
  3f8:	3b ff 00 04 	addi    r31,r31,4
  3fc:	42 00 ff f8 	bdnz    3f4 <__c_kernel_getrandom+0x3f4>

Please restrict the patch to clang builds.

Christophe
