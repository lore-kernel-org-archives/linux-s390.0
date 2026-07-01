Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD473815E3;
	Wed,  1 Jul 2026 19:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782935928; cv=none; b=kewiYcim5VFRf0U7B5o/HSxkZnT70GefgDS7aO0z94ShJ1aq6RYFiSwkyZGMNpLou+7AZQYFxvxRCfAr2rKgfcBlwP+xrHVLNieTsQONJfs0syrc53kW6CDS6etxfK7lKFPakO/uZQbmPU5Jax+G5AvV1tQ4+X0CYIVutH0xcUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782935928; c=relaxed/simple;
	bh=cC3grrbtW7yIMNoaBOflGzRt/Nk2jP+A2DZ0a6yP4kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnlIikAwtOPjKkyySQo8pf0VS16O/268WLkM3edXRsNmlMry+xg8wreJHTQ+UkPc1axXn5+OiuKR5EPvy3K5E0RoPWvvdvB8d/1YrD1EajrBYGWvzBibPjNZQhYl59Cys84cJd6astFcraal6g6TSvkjESFkBD3Jz2IHn/02ZGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RAJ3Efqo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1SUZz5LD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RAJ3Efqo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1SUZz5LD"
Date: Wed, 1 Jul 2026 21:58:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782935924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HGRGPG5nxs0MWmKVH1XE9+ETMnAwiphDMI53H6S+Wgo=;
	b=RAJ3EfqoP6AG9c1WaCNIITbaruiAfTva7N92jqjyzHz99/OruOfTsQ9TCd5norcqHnFuwa
	K9sh09kmJbujZbohmQiFhoRumZZlkBpyLFNp1xSsQHibl5CYF+m/TJNK1JhQMyAn4LmeYK
	vdaEeUVaGAU+fb3jPhlEJA3GzYYBti4GYIH1mbLCU4yq2vg0A1P6iRNphahOyuLvRiQCzs
	G1ZivJCtGVTCUncdkOK4rty08ys6o4EvaF5DGpYcDpyLTW6lNjZo45NVlQ3WiTzvV04wgl
	nuZ/G2Tc5emil0fKKVXCMNNGwnTOt8sLqOwW9B3eQ381vduezgRl0dPzG4QrFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782935924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HGRGPG5nxs0MWmKVH1XE9+ETMnAwiphDMI53H6S+Wgo=;
	b=1SUZz5LD4PErOtj5qqBP0NkzivGmhqyBp9E8O8FyVIUjOEo15F26+TZGAU3SxaFSaSBgu/
	gXmhX52PlPw+fiAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>,
	Charlie Jenkins <thecharlesjenkins@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Thomas Huth <thuth@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Jisheng Zhang <jszhang@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v5 8/8] futex: Use runtime constants for __futex_hash()
 hot path
Message-ID: <20260701195842.GKzb73-i@linutronix.de>
References: <20260630045531.3939-1-kprateek.nayak@amd.com>
 <20260630045531.3939-9-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260630045531.3939-9-kprateek.nayak@amd.com>

On 2026-06-30 04:55:31 [+0000], K Prateek Nayak wrote:
> --- a/kernel/futex/core.c
> +++ b/kernel/futex/core.c
> @@ -395,13 +391,13 @@ __futex_hash(union futex_key *key, struct futex_pri=
vate_hash *fph, struct futex_
>  		 * NOTE: this isn't perfectly uniform, but it is fast and
>  		 * handles sparse node masks.
>  		 */
> -		node =3D (hash >> futex_hashshift) % nr_node_ids;
> +		node =3D runtime_const_shift_right_32(hash, __futex_shift) % nr_node_i=
ds;
>  		if (!node_possible(node)) {
>  			node =3D find_next_bit_wrap(node_possible_map.bits, nr_node_ids, node=
);
>  		}

I replaced this with:

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 79e770d4d166..30d8622958d2 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -382,6 +382,7 @@ __futex_hash(union futex_key *key, struct futex_private=
_hash *fph, struct futex_
 		      key->both.offset);
=20
 	if (node =3D=3D FUTEX_NO_NODE) {
+		u32 node_limit =3D nr_node_ids;
 		/*
 		 * In case of !FLAGS_NUMA, use some unused hash bits to pick a
 		 * node -- this ensures regular futexes are interleaved across
@@ -391,9 +392,9 @@ __futex_hash(union futex_key *key, struct futex_private=
_hash *fph, struct futex_
 		 * NOTE: this isn't perfectly uniform, but it is fast and
 		 * handles sparse node masks.
 		 */
-		node =3D runtime_const_shift_right_32(hash, __futex_shift) % nr_node_ids;
-		if (!node_possible(node)) {
-			node =3D find_next_bit_wrap(node_possible_map.bits, nr_node_ids, node);
+		node =3D reciprocal_scale(hash, node_limit);
+		if (!node_possible(node)) {
+			node =3D find_next_bit_wrap(node_possible_map.bits, node_limit, node);
 		}
 	}
=20
I don't think it is worse, I hardly see a change perf wise. Sometimes
op/s is reported almost unchanged, sometimes it improves a bit.

What it does it reads nr_node_ids only once (which has no effect here
because I have no sparse node) and it replaces the shift + divl with
imulq + shift.

perf was pointing me to the divl but now it points to the imulq.
=C2=AF\_(=E3=83=84)_/=C2=AF

But having that div gone, can't be bad, can it?

Sebastian
