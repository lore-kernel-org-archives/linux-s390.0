Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6436E5476C3
	for <linux-s390@vger.kernel.org>; Tue, 29 Sep 2026 17:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790703868; cv=none; b=hP0eZYD3ZzCx/85hZti9up+dVA4nufdMYSI+0YuCAgSdL3NEQAbjSxE2pgI79bQlx4Om0YUSqwOhE6pUIcf58nOzETgqPckR48o7ECf1a7c4WY9oxavxAFmIK98zozaBOAort+UZ3zjR1dKbmEWc7Pgv6MwFjkKR9gFrCmURDKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790703868; c=relaxed/simple;
	bh=0xBkcPblbpjG4vkQkMpJRewja3D/3gtloFXrU9YBVy0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dfryeynxYwxpX1503w4K4Pcq5+JzZ72G2yHpHBuPX0JDNY51KQR9FxOULi/Qrfs64B6JaoGBw+Ky1A/wMf2JnSlGYJJc5bsoqf0MR1S5Ay7hH8QgombJ5a37xFTkQNnQAJkGcSfSUZEaWWhtNIsHHmPENIFb/7eupwosw27mRTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=at3cWKpM; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="at3cWKpM"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912df756so35116825e9.3
        for <linux-s390@vger.kernel.org>; Tue, 29 Sep 2026 10:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790703864; x=1791308664; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k31zVVbNicpwi9YDlhFvR6Wyco71XCVxmV3/xYq3pxI=;
        b=at3cWKpMhGKj8d+1+sqvMlItz70CUXrkUiivMhFNZII1Utz24VaNNZEW31ohThwo2f
         PDFYEGDTa5uSmd7Cl5FcwfCxHUwR0n0wQgeY2PGZtlHs9u0kyvaTHTYj3ue2tWCW8SZp
         y146QBqMApBK9L6BJHy3Ls55QWIcVruXpBR3yViRPUoXR19yXE3oiPp3u91/rYAc72+D
         /rIvXfGnZJ/SEt9KohJUaGHUuAV25KXNKQRjA+oxpWAzYAtfmgRHvjrl0O+fs5FVC8CK
         oBk1n+QFMa6a//dDx7Ge5rXzjwYmYlbhOJUtg+W/HTkWD1SlsDVcz3TISIpIVaGTZCPa
         M+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790703864; x=1791308664;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k31zVVbNicpwi9YDlhFvR6Wyco71XCVxmV3/xYq3pxI=;
        b=izcS2jGUtl/a/c5R0ZpQ8f3nweU9J9j9t944LkVERXPRyQPj3/z2r2Hy5/VPSncdky
         MtBDtBMpbVKQgCcKNORc2Szy3ndLeAhxu85BYXJ7IW54JhTe/xHAEgkIM6DuE7VJHM6j
         7WXoyfFB7ntlHlDxrwDgptpP8wcz7/dMXzI0XINwfforEcAE9got1pQQAwtMWIf/5RyM
         aB41DaWGXYieBguMuZgxDDgwW/wRAikBHEd5R3EurprUggMH3sK3c1teeXFEHUzDkOER
         LqVj19WxYFMFES7H6L7MiRdtXTxjahO0I3vMDdmo9OO4unOKM6UatLJVuH7FaRuAUCTC
         HIwA==
X-Forwarded-Encrypted: i=1; AKwUvBz6qizPGl5aNrwWqoPSo8ypRZxhLANswkQE/NPfSdwXi8ffVXHB8Alf66P9wohzq20uWwXjwxIYHzUf@vger.kernel.org
X-Gm-Message-State: AFuF++kAxrzU1Elrun/1jdwUT21hM91IH13yh5lVg1DbgDIUQkvCKodL
	K5HLbTVpev4wsdJYNRWMgxFUffBLZip/V7U1faVfJYXki0/AWXevjTZn
X-Gm-Gg: AYBFou3ULgoAFxmDQQL0qVIJ2K8eDa06i4iYm4CUvTRWTaIOdxgAHlQVUyE4k8SXT1/
	NXb3ONNMNByrqlzsqe4wV9Xzl7hmRqG751rQ12ZwxvarMgejgVUGa91wdVNHrZwB7N1/4DK3j+q
	dPFcsIaWzF5RHic2izyC1cY0VDEMN7NvFkmCmOfNri3BDjm9n8KIQVDuKtdw8WopLXDFq61NC28
	LT96aNw8xGBD+BjFigmbToasDSpnjN7NQQe+nEEN+CgnlZHinAqj2NXPIJ7jyGhWX/G16BJjoRK
	RXRiJU/v1g+ehs4uKhXggXl9nPt5ex710cKaniefth4ik20cKeT30rV+xnYwehF1xkmtzmxEJo7
	MpqcbHowCzBS1FLNmSknvNjBYmJOC/onY94t8EsX6ohu+Fo81H6d2x4yp8YIyWTsSVCOBOMhpSW
	eTwSMnRVPeD2yb+0vCSDoV5ed2+/G8skbYTrYi+bkeD2nbMsOZ+PzRZHQqYjLttpnkNl3u6N251
	1Ai95H1CPCSMo3eem6FJRkq66C7GT9QPEA=
X-Received: by 2002:a05:600c:4e12:b0:49d:1842:f001 with SMTP id 5b1f17b1804b1-49fe66b6e0emr305056015e9.14.1790703863276;
        Tue, 29 Sep 2026 10:44:23 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cfae123sm103285395e9.13.2026.09.29.10.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 10:44:22 -0700 (PDT)
Date: Tue, 29 Sep 2026 18:44:15 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, Andreas Schwab
 <schwab@linux-m68k.org>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner
 <tglx@kernel.org>, Theodore Ts'o <tytso@mit.edu>, Vincenzo Frascino
 <vincenzo.frascino@arm.com>, Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2] random: vDSO: Avoid call to memset() when zeroing
 reserved in __cvdso_getrandom_data()
Message-ID: <20260929184415.1920fe91@pumpkin>
In-Reply-To: <20260929165939.GA1890629@ax162>
References: <20260925-vdso-getrandom-avoid-memset-llvm-24-v2-1-ce640f872393@kernel.org>
	<87zex4ic68.fsf@linux-m68k.org>
	<20260926121927.GA1486962@ax162>
	<are7cfMIHZZn6jLz@zx2c4.com>
	<20260927080225.37534e7c@pumpkin>
	<20260929165939.GA1890629@ax162>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Sep 2026 18:59:39 +0200
Nathan Chancellor <nathan@kernel.org> wrote:

> On Sun, Sep 27, 2026 at 08:02:25AM +0100, David Laight wrote:
> > On Sat, 26 Sep 2026 14:32:49 +0200
> > "Jason A. Donenfeld" <Jason@zx2c4.com> wrote:  
> > > Do we even need to return a value at all? Might as well just make the
> > > function two lines:
> > > 
> > > +       for (char *d = dst; size--;)
> > > +               *d++ = value;  
> > 
> > Wouldn't it be better to add a barrier() or similar in there to
> > stop the compiler playing unwanted games>  
> 
> Wouldn't that just result in the same code generation issue that Jason
> pointed out on my v1?
> 
>   https://lore.kernel.org/aquyVkdYceiWdckX@zx2c4.com/

I missed that one going past....
You only get 'rep stosq' because the compiler first converts it to memset(). 

> Maybe that doesn't matter because modern compilers have better options?

A lot of cpu will run the 'rep stosq' very slowly (it has a big fixed cost).

At a guess the loop is 3 clocks (possibly 2; but that usually needs
you to use negative offsets from the end - and gcc doesn't like that).
That is comparable to a mispredicted branch (and you might get two of them).
It still might actually be faster than the 'rep stosq' version!

I suspect the fastest code is to unroll the loop.
	xor %eax, %eax
	movl %eax, 12(%rbx)
	movq %rax, 16(%rbx)
	movq %rax, 24(%rbx)
	movq %rax, 32(%rbx)
	movq %rax, 40(%rbx)
	movq %rax, 48(%rbx)
	movq %rax, 56(%rbx)
8 clocks on old cpu, 4 on newer ones.
But more likely to be limited be I-cache reads.

If you are going to use 'rep stos' then you might as well write
13 32bit words.

David

