Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792635520;
	b=yNZHL4GBWxK4zgr5y7s/4sIDws34eMrhrzpPfPB1JRvUEMZONUODaMFDNiUEgZWu47uz
	 M+kLPs+TQvdxqth0BKV5o9u6GISKzcpNJWguM4ZNk+L0spJx2JwBHqzzJhGPuXS8DMeNr
	 0q6Aaj9n4GJKtwFVjJp1ROcZ7/lo3pBEIEKoNAaele7Melvh+ZhKW4ur0EfQEQu8OHD3Q
	 FjqTFJJ5XAaa45M9ZnN1vRbjZVZvPN2zUzh/nr0K0nhe8wxHSviGfROgYt0PN8phIwJUU
	 VCNY1n14Kdy2jC6ZKzVJ8e4jWUICEmrta6plVHoCfok9i1l0b8C6LjLO50BYv1XcVUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792635520;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YVLKVn5aYrORuK3mJHdyAM2K05yQ1I4f1Gd2eeFrBFc=;
	b=L6MloFkCCCxBhjpYWYC/gXx5v8hV0Bz6swvtNbMaAMrNxRB6rSbn0NSC7QfVTrlP5Shx
	 b9Fe+RlQH9FhKGE109F9XB+mUC5sTFH0QaWMCjsn1rEVKUpOxViKMO0/mGa1YZI6HG8St
	 RhzX38Nuo9K26UTVHiXTrUvyZL4OxgsPcaxCuxs3KNkC3LsN/v2rYVV7HkPtZIBmY9U4G
	 R4hvd4tFXyTXE3itjVFjWFxK62eYjKZ8tD0d85GhJgW2G2GLz4yaF66niaru3iG4lVu7l
	 8mWrrlXSJfhEppbwdkAz8CUwl8/DI1lImThY5JojQC3HV67j8N2Xqyf1w6X9xQoiUxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H+eszt1v;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0F6606A322
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 02:18:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA0F6606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H+eszt1v
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so2607062eec.0
        for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2026 19:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792635519; x=1793240319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YVLKVn5aYrORuK3mJHdyAM2K05yQ1I4f1Gd2eeFrBFc=;
        b=H+eszt1vKQtCU3/KB7Qzaij69qenfu0lG2XuIF4ZWISg5dYrkmC9asbrjtgR4CXkce
         TBXb4GKHG/wsSGQ+UrZ8+zEcA1NQgtYK91w+B80ULkg3ASikYfCo9UWfYmfwpvEte4XE
         jTTxbKPQVXpeU8ktIhq/YTivJtLdLSAXqmVf38FDGxukqYkaW7iUTpvQyxAALnq6XXGD
         ci38T/qydDnsRZLVQQuKo0hUWVY5R+df+t/heaKrcLMGs9Hz98Sz5r75F5L7LBqWlFQI
         egjfA+nNUHRlxwEXpwXcYyyWcLr+UjLA/NnupQKuiAMqRo8yIe4c9Dms37/DiCtx6ifF
         hfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792635519; x=1793240319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YVLKVn5aYrORuK3mJHdyAM2K05yQ1I4f1Gd2eeFrBFc=;
        b=VJko4JteLq/Bp83h15LQ7AtFObc1NLJk6kTIOgCI8TYZAAF6BPdl+bEz+i/z04xI28
         r9X17dI9FMUoRaPihYLZzLk3Lai68mM3nI2mxm+iqgxOpu8ADUCCNu7jL/mzbaHMhRhJ
         /SxtEFPwSqrNpEtH3rvtZyljt4MXRCSXuoOn2JEdjVQvToPX63Yo9qEsbcU3N0pYeqXQ
         m+EoGjiid1ydI+5Hh8+o747FOF7XbJ3wxupKH7Zq/W+gDGRO9Hcax2xq3tVUQgd55rSR
         UAevta4BrGG1t5TvwIE9zW8uGuEYdx7ijm9/lgWcUrNEe0S1SS25IjZbhcM63sgdCja0
         4MZA==
X-Forwarded-Encrypted: i=1; AKwUvBxzetLYUpMEOlnbNjke/G/bQE7JnMg/w0mUNysSUgnxJHpKwyInoMl4mXMLL2UCUPdwnj577moV2APo@vger.kernel.org
X-Gm-Message-State: AFq9FYIj+K1eww0X3QdV1CJGl16UOVd0bEq5SFW677GZHGFAvy2EHjDg
	7NYG6qjXupMMG88TLNGBurf1Noqj2Yl4GmqgLCYtliygFo91jLPpg7WC
X-Gm-Gg: AYBFou3GqkilGgDXL+/hceoHG6t+R5c3l0mTJIi1TOsvTjrV3bPZZUiTBH00zseNGWA
	GRH/WlBZup7Y/RcvzCANwJlPC4Tie40SWn5XrCLehoktJiTg/oAVRRTxcB1vaE5OfGzcGF/KeaM
	wbCY6fEM3pu1lotNe+q+lYiGCqBJ1HkX6PSckjXqp+W3CjeuEAl2Oql2sebMVFExkcnGUP0UVjF
	yRVcRH4Y8FzvSFj22CIjt3j/+LAsfbTj28yUiw9DaI/oghy1Bt2mT3c61npeURtBtMmbqyddGIs
	qDDnAhNx2bYjcu5s8JAg5HYfW8X/Kmnk1XdB8gwy9hXiP/BSuVR3jCjYSfAsIWHT9d36F17GJyI
	7WS4Vsk/e7f62gb/BFD78SmzOmyWSVYyuKErT7do0e5aM+mtJ2JR2F5OM5otn5/GMekJ3UgcR5L
	sd0hH5R/xf5VGqWiuGZ8VYedMO6OjVEJpHTL3Ndzgs01HDqRPgmKDwsYDxvNQPuXfRvqkq+vL9R
	s8QaV0oPx2xhKUGtAS4CtFlr2j3jUrGv+6YPf6NrQyf9nU=
X-Received: by 2002:a05:7301:618e:20b0:35e:2c6:d46c with SMTP id 5a478bee46e88-3674c63d579mr5523810eec.10.1792635518735;
        Wed, 21 Oct 2026 19:18:38 -0700 (PDT)
Received: from ubuntu.. ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-368b4b8e9c6sm3556805eec.1.2026.10.21.19.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 19:18:38 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Shuah Khan <shuah@kernel.org>,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	Peter Collingbourne <peter@pcc.me.uk>
Subject: Re: [PATCH 1/2] word-at-a-time: check the first byte in load_unaligned_zeropad()
Date: Thu, 22 Oct 2026 10:18:20 +0800
Message-ID: <20261022021820.1789083-1-odys.yuan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAPAsAGyrH1quaLuyui6Qm5sokid8=yjNbAM3cOunynfPNQtfgg@mail.gmail.com>
References: <20261019-bug-word-at-a-time-zeropad-kasan-v1-0-f21a3ed6a477@gmail.com> <20261019-bug-word-at-a-time-zeropad-kasan-v1-1-f21a3ed6a477@gmail.com> <CAPAsAGyrH1quaLuyui6Qm5sokid8=yjNbAM3cOunynfPNQtfgg@mail.gmail.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 20 Oct 2026 12:58:54 -0400, Andrey Ryabinin wrote:
>> +	/* open-coded instrument_read(addr, 1), as in read_word_at_a_time() */
>
> Why it's open-coded ?

For the same reason as read_word_at_a_time(): commit ece69af2ede1
("rwonce: handle KCSAN like KASAN in read_word_at_a_time()") open-coded
it "to avoid having to pull the entire instrumented.h header into
rwonce.h". I kept the six asm/word-at-a-time.h headers to the same two
small headers, kasan-checks.h and kcsan-checks.h, rather than pulling in
instrumented.h with linux/bug.h and kmsan-checks.h.

Thanks,
Qiliang
