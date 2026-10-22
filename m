Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792679618;
	b=o+9PCUineyyiIuCOez0xvhLYMv5NGEZ0faHmHbx2VeD4E9+J+4VJdY9QHswIETzXKBS7
	 WYE7hASph6iQ8EosySeq3kSi+5lxC/rmzZJxZ+MBVSzRy2xdorL/ebuugMeJPmoySpj5I
	 RIu5xDjAbrKv48CtdPUlk1q7Pp4AmtCNWgrehA2yQXeSXvXX2jbmzwYscZv4YSGllup0z
	 uOY+edoGjl8EgmEjMV4cVO7Zf4bg+BgbPt2TbRyNz2Ge8HHjmlPsLDqF1Y4ajloensDt3
	 bL5Xoc4f6iz9myVhveKZN6LZ9eJ0TlaG5y+67Gm0STrwcTAjR1BAi1zY36h3QMs6Jqw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792679618;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=y/nVz+Qmk+Tq2vmwCZBWANvE9dUy6Fp4Dxh9VLxLk90=;
	b=qW+aQiiadDwjrjAqJg0h8Kk6JeyFS79t4Mf6g+bxbnDU8CKLe2TMEVQVJFSnup+njofb
	 ZcLcLQZ5Zv3DZ7EcfOoeBTGJc7fnkrcdVqRTB+r9AgP2bbSxUDu0aeqC6RxWoPIywondV
	 EPVBK9Weysxfy/gLfBsFS0SWvmMoA+OK5QjjXAmi7XJsudCMUjxLFSyTp9eG1Px7AsILj
	 Iwr6uSzmWrQ6OK9YLnbdHPwrDYLA5ymQGhjrKcOrhNVZnTzb0bHP/A5Y7VBk0/X0p1uWW
	 mQ84YgvdFjJjufUtGY1kO0BtMlUaF6Ad+oJtjp/BHR+EU1sgS4DqSx3+o2tCIBwgw7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PRAZE+RY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39A9606A325
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 14:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B39A9606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PRAZE+RY
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-673504236d7so269991d50.2
        for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 07:33:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792679617; cv=none;
        d=google.com; s=arc-20260327;
        b=leUGW0Q/z3/GMBEpRcAl7u+QkMbRh0J+kM9FAcqs+3osF8KxpwfhZqvyYMdEQgNrjJ
         93gDM14z/9/qROaOrXCcfDB5qm091bLDAuaSYrtjG7X+LtcvYbB3du8qeXzhj7BClb52
         IZd3tSVZZ341SRpsvRxKyvzOzmQDtstqyMAcoBR1fXEbucwW4864/q7w4MrAogSWI/Yb
         aQvPWMfyzRLrYenls0lpzNtx8bORT4Fb3E2/B+aAlXOm5pS7O1dgMEFBoCWeKnt/v4L8
         Ler61vLZrw46EOlupxAS/9c20vH1YDLtKs5F63IHv0HBAoTTgMAfFGIuR4ibA9p6RNsT
         xyPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=y/nVz+Qmk+Tq2vmwCZBWANvE9dUy6Fp4Dxh9VLxLk90=;
        fh=wcPfs7LwMGppC93yC+Qe4pnaXIuLpYFfxm2f+IQNBxE=;
        b=e+3Sfm5WMhCkQyeIlwt64ji9BZxR7LNp86gTxV7swbADXjO9vzHvPtmBZG/RvP9JwC
         wJQb4k8SPQ0i301BBfS7dltIBPNQt/FaYtxif9E/aRL7SGEl9KRQxPr8dQzUVb5KFF4S
         wsCfpkqzIntw65NRa6Hn1XIqQsXy6kL4UYurxbp3bisaD88jsh3sB+IlENC1gaVFz1cb
         tonr3NTOkNjdCrH9faNRdd8hn4mZxH0YOchAqsSzoL1y+DVP9dsHaScqgF2w1KYnxzQ6
         sTG3APg3JnxjqIW/tCutfINcWNcneiYALhS8NzDVK3xOLINFFEoHy2z6l04Hp1QJTrTZ
         yv8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792679617; x=1793284417; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y/nVz+Qmk+Tq2vmwCZBWANvE9dUy6Fp4Dxh9VLxLk90=;
        b=PRAZE+RYa/Hi/i7xszdGfO18YYUcERJGPuFa0TwZR0t/KCrkPe/l8S2bcMOAWdZjqn
         hDDsdq5ywxDCW1BdnWmT1Vx22odyBbS51VQ8aTxh7sVxlPj39MtKsFf9kaDZRZt6I+VS
         Awo2q4mT5v2dp3Hr8ECD5NRpuvxWXUlDcw+V0hlIOsJyWgEZj3HdmYJzoUsq1EaOzM3Y
         GnFKT0Gabxv9cGavL7y7NU3KcEKv/Ze//jDMDIzwAsmpPiE0Y8yEZRy4JpdbLEC6egvy
         0OB1FVsaeSIl/Y8D7dEWMAKxf5Thjt+K5PGVV7iuV7wyIYxknzWorZgiLk16hIoN5wAO
         u2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792679617; x=1793284417;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y/nVz+Qmk+Tq2vmwCZBWANvE9dUy6Fp4Dxh9VLxLk90=;
        b=Yrws1au/eMrzYa7Qk961bG8ZvhMiyTChxsjgOqqUTU9UFNMSIXdZKmqef0WYiIQkaA
         e8G2lCLJsqlQpZ73OSSJU1LPeYV3A4/1z7dIirn6CS+CJojYw9D5rqoCAnmyMlt96ugL
         UbDDNMS9UiDEXn5IHfP6wypKCww6WeHQwFSNhG/JXMvj1GFC9CrKwuccLmKxhuOljzaC
         Usxc50pmlkLtUSAYXJKDp3BYuOt7wb5abMTH3quoX57rvnd+JVE9VWvhgg2ngfxexIF3
         yH7HYkHwJky6iFG1WYC2LaXKfB4yZjTCQs82EDnABM3J9+bstzppWsXcCV3x7KCFVPK0
         4qZQ==
X-Forwarded-Encrypted: i=1; AKwUvBx9yliFsyBLP02Lj5mE195/lwRk8EbHjPy+1kgt2yinnwI2MF5oKTk4wkxeVz1qD1igxG9WTaUBgKl4@vger.kernel.org
X-Gm-Message-State: AFq9FYLexXvcbLeE/GfAeUXFOuoZdAMZLPcucMWYq/oRtdRrjdeiraaq
	rgahTZFzeuZA9+tjxy6cxNEUUA3p+8esk6+admeJ+dB48ztJSvSQeYAFe75MZztuYwINwuTrfRV
	y3Kwbh/C9ReQochnRejwS9dLjAaFU9M0=
X-Gm-Gg: AYBFou2BedhrwP8h5WNE3oVgwgrGnpCUnVq2QFkPEmtP+P/zbHPXftF7/ZzsvxmxT5q
	yARtV2oXIZe/wVrRFIppazFMXgpvn5jGSXYPais0Fw9y9J9MzLX23+pHE+aEdRKDevPeM/QHqtD
	gQQvRL5tqAiKMedfQn+9APH6ICCu/lORh2iqyWtNsR4X6sQyAVCDhscVTN/CET7+QtX9I79f09b
	3dt3Yk68W7OzfokSKAgg235UALKj9hyVXX/+i3jYshijRnq43pOqfbFxGjccVJ/BwoZDwh1rxKk
	2nPmjyCHA2URJoy5OItHjUYSIOe2Fr9TqKEUeSEC4jtEcjWxm9TnrvV+B4yD+3+jqwFgke9j3zW
	XvJUyTFARuecJsWFmSrrT68QWXMG4L+QM/LU=
X-Received: by 2002:a05:690e:4504:20b0:679:9e25:316c with SMTP id
 956f58d0204a3-67a0e4f7118mr3858513d50.5.1792679616649; Thu, 22 Oct 2026
 07:33:36 -0700 (PDT)
Received: from 95991385052 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 22 Oct 2026 07:33:35 -0700
Received: from 95991385052 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 22 Oct 2026 07:33:35 -0700
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20261022021820.1789083-1-odys.yuan@gmail.com>
References: <20261019-bug-word-at-a-time-zeropad-kasan-v1-0-f21a3ed6a477@gmail.com>
 <20261019-bug-word-at-a-time-zeropad-kasan-v1-1-f21a3ed6a477@gmail.com>
 <CAPAsAGyrH1quaLuyui6Qm5sokid8=yjNbAM3cOunynfPNQtfgg@mail.gmail.com> <20261022021820.1789083-1-odys.yuan@gmail.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 22 Oct 2026 07:33:35 -0700
X-Gm-Features: AclHuK9KZnLcDmcb3UzjebEw_JXnOgl4qhgoWZHIOId6L7KU5VJDln5TqsxLBMU
Message-ID: <CAPAsAGyA=WG=z6a==N3O6oan6WVmZS-VrxEA7SrxRQs5d+Dsfg@mail.gmail.com>
Subject: Re: [PATCH 1/2] word-at-a-time: check the first byte in load_unaligned_zeropad()
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, Marco Elver <elver@google.com>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, 
	Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, Peter Collingbourne <peter@pcc.me.uk>
Content-Type: text/plain; charset="UTF-8"

Qiliang Yuan <odys.yuan@gmail.com> writes:

> On Tue, 20 Oct 2026 12:58:54 -0400, Andrey Ryabinin wrote:
>>> +	/* open-coded instrument_read(addr, 1), as in read_word_at_a_time() */
>>
>> Why it's open-coded ?
>
> For the same reason as read_word_at_a_time(): commit ece69af2ede1
> ("rwonce: handle KCSAN like KASAN in read_word_at_a_time()") open-coded
> it "to avoid having to pull the entire instrumented.h header into
> rwonce.h". I kept the six asm/word-at-a-time.h headers to the same two
> small headers, kasan-checks.h and kcsan-checks.h, rather than pulling in
> instrumented.h with linux/bug.h and kmsan-checks.h.
>

That concern is specific to rwonce.h being included from very low-level header
like compiler.h It doesn't cary over to word-at-a-time.h

> Thanks,
> Qiliang
