Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4723ED5DC
	for <linux-s390@vger.kernel.org>; Mon,  8 Jun 2026 15:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780931849; cv=pass; b=jecRqoNSCzl1uSK1rvX/jmmfM4dVvOyolZ4RY8/0p2MJO5d2YwOufbZcJgXIkHvdV5JvldBt+Q7A/v9730l7aetJLQ87N0oiOXPptrgSfjByDXshIiAWMQsW+7LpTot+DXrVNZHvlMmozsbiB+VytxwVzIpQfHGyGSZRTapn9tQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780931849; c=relaxed/simple;
	bh=xNi8/se+D6WaUt0MaPlNhEUr89OFCgbXcuKuMyyUBIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WHdvxYb12KkVRYO9mP/guHFnkZRW3SUYUT4o0cX/9wilqWJb4ioxNyM0EJDV57Ic26q8gQnMnuRAn+pkeX7kAkxyuby+Hdslx15FoJZ0BU6CJ0NvmJEnKeRgINF9MuU03vqWOuG83yVl3T3usFlfZPCcnqdLs5s2jKmyfEtg4zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vn7eEnVn; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vn7eEnVn"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bec449d0af2so501460266b.2
        for <linux-s390@vger.kernel.org>; Mon, 08 Jun 2026 08:17:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780931847; cv=none;
        d=google.com; s=arc-20240605;
        b=h6mglmK/CC1WkNPdL6F9JdtxuLmHcf00NKUaNSzc7V8EImzY87rRcheZF5PYETEoSP
         EoGJXmt2OHCtp+RCu0GTYao9pTi3v/GJ2wk1lT/DP1ThQinzZRDM8oX40xKJBO0EerrZ
         eWF+ja1+ZxaS42fZKC7DibYo1oc7OI7eHGhmehcUPZbZoILax41x3cfgqHLRanuuNGnt
         7BybJUNmk0Vn5ac0aZYVq188d3UxTLk/DUxqbLgUmCDFd45vPUcQSBv8OAgTfTVjPJHX
         YPzw8Qe9cc30yG3JyMarDtxsGWnuP65Gunxbn4qbvL6HaUNbVfvxwXYrRoyr/XgaOAOl
         85FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yOZ7AW/TQxNVQJPSlsPWX5PMQzNffbEW+fgTz/Ammvw=;
        fh=C51frMQiCNk93GbbVFpeJ1kWMlW4n4aT0VYuV818D2M=;
        b=Jn1jZywTQAQWvlmM6EvgktpXnkOURRfEh4BRlNtZLyZnTrozqep4ki6+TnqZSwTQPr
         10DNZWGtAtrEhkChVuHqq005jCKiCN3NXIZm7DOSvgOrwffCpmUwA2u5pLPNJTS7YqO3
         9jXeV+9pZkWfOo37QFlgGeYQgvKC68VOBzDuRDAws1EcGqM7JL2Gwa8bGwJ4S/v7bJ7Z
         dbmVHN1TC9fWq9fu5HyDf5rLz9Npi5fTnsyer4vAVUXnrfWzWHk2VArmctXVb9yhgIIi
         4UnmJ0vaCP383ZLzdGLzQRbfFhufW7WvzbTWJoB7pqkCe/JyxeomH3XfyP6+QCo9uTWl
         3FUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780931847; x=1781536647; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yOZ7AW/TQxNVQJPSlsPWX5PMQzNffbEW+fgTz/Ammvw=;
        b=Vn7eEnVnVtZ0oi18uN8Pawmer4RkEBn/0eLXuw46rhajkOqtuK/bzEOkGZyEalScb/
         GzeB9Tyl5aFJKCXXZ87myiaS/U6eYHhCdSuHb38hUF5+oHnrfucIU0Dbcdi4a68fFgYC
         Y+WUVEiO2cq+KHmuFOtwMCrJV7nF75n3KJ31wqbrcTXq02IRwCYGMu1NOeIxfYJGqx7J
         cdwpPDno+Hh1ipVRipqT0S5xietArPB86sdkx0vl/HGkDEtJ2YGDk4SB1DMFOoDWygM9
         mFm9OPiQytvGdcp/5LiEbVzZq6wAhdUuiNtPnuXJMdQoM9I6yLCmegYr8NcdbJdYsSDw
         yxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780931847; x=1781536647;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOZ7AW/TQxNVQJPSlsPWX5PMQzNffbEW+fgTz/Ammvw=;
        b=CgzCyft+XThoEgJkkPpHn1MQMzzcSORv8Bwdm8TcQjb7JXku5n29wftlk0HtFaUlFM
         ljBNYZSOLlf0OM8Kv87ghMz5bkmCH9zRYsnTcbNSd0m6py/+R/JBkX072h2qGLWlVlks
         Wurbek1h3vUyaGlVmjKwHamCuNFEa5kutzqjSi00Nm0konmEJnODLWKOd3NjQOi1VZ88
         Fe02mY8ERLUmLtQAgQYUAp8WW5o3EOnGU1YW5KCOUCiGKo5hexaKhe1uT/jJuoJTzzfh
         cNZ6UWSnSiMvoL8TXerHs5azM8ylSeCVBvOV++wYfhgsR33mfuaYRmKxKQDuEwldkkvQ
         264g==
X-Forwarded-Encrypted: i=1; AFNElJ+Vz7p6VUzU2LScz5VJaFcuzncupu6lWwFvAYTLWdya1MNXUeAvlHy5572ReYbIMXvbpWd7frKavZG4@vger.kernel.org
X-Gm-Message-State: AOJu0YyHZPMVDbQ1ms/cBH5caDeyGdL4ktJygK+Peu9igqKC2JD9Vtxh
	owsG8/q4CGnovmU/Sa21Z9P9xELE04llOv8XI1Z2BDxtMJDdmK5FU2d1jbrnElUzBcMJKqSz2jh
	fjz9C+HazcrgIbaV9l5YScxb/AiHus6Cbu3/uOPfoRw==
X-Gm-Gg: Acq92OFo2rO9gZnCmuL7aQDXeS1c735pRb4ZFg5vUzg9RhbfFGWdRHOjiOHZdKyOTQV
	kzWnIBFp4VEJHQklh6MpglhaEuzZBOK+LHOKTuoWNOENec4wWOG3x1eXEPzz5eA8gKUAnIMAaaV
	XsseFzsJi3IRQOPQYsY/W9aJvqdRbTb8M8MXCPocvCpZF9+H9J5Y4ONo4wQr5/EIOdBp9GsXT2i
	kt4MMAFYWz9Tk3vIDWH6N2lz2voo9jcqj9IwDp16mDRrYyUB/OAJJRjB5dfoUHRRXObWw7pFku4
	gD+8H6WQ7X8ztoRvfbDjCfPS1udGaPFeVvKyEg2QvVZooROqtzVJgunFFqM=
X-Received: by 2002:a17:907:c22:b0:bec:d077:c4e1 with SMTP id
 a640c23a62f3a-bf373ff1dbdmr731904466b.47.1780931846675; Mon, 08 Jun 2026
 08:17:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522225853.878411-1-tjmercier@google.com> <ahPqbfH54R3JJyaV@infradead.org>
 <20260527160716.GN2487554@ziepe.ca> <20260604-dangerous-tuatara-of-sympathy-28e05e@houat>
 <CAO_48GEJsg4X7++zg-ztQgVibY_FjjManaA5_W3usjicGUQPdg@mail.gmail.com> <20260604135712.GV2487554@ziepe.ca>
In-Reply-To: <20260604135712.GV2487554@ziepe.ca>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Mon, 8 Jun 2026 20:47:15 +0530
X-Gm-Features: AVVi8CdcrMng9NlewA5irjsXERkw9Ix0pSFdV0gf1_HiahCuxCNItaDbqkFH3sQ
Message-ID: <CAO_48GH3NP09U6TdB5drbKY0TpwvtBXwrf=Jajsr5ttNbC_u9g@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Export set_memory_encrypted and set_memory_decrypted
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Maxime Ripard <mripard@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	Christoph Hellwig <hch@infradead.org>, "T.J. Mercier" <tjmercier@google.com>, maddy@linux.ibm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, 
	linuxppc-dev@lists.ozlabs.org, lkp@intel.com, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-mm@kvack.org, agordeev@linux.ibm.com, 
	gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, 
	Dan Williams <djbw@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org, 
	Arnd Bergmann <arnd@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Jason,

On Thu, 4 Jun 2026 at 19:27, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Jun 04, 2026 at 12:51:49PM +0530, Sumit Semwal wrote:
>
> > Given that Christoph's objection is not really about the modules part,
> > but that the set_memory_{encrypted,decrypted} should not be used here,
> > one option is to revert 78b30c50a7ac until that issue is sorted out?
>
> Please no, we have stuff already using this so it would be a
> functional regression. Revert making heaps into a module since that
> doesn't have a functional regression.

Thanks for your comments.

To me, it looks like while system and system_cc_shared heaps share a
lot of code, their user bases have different needs. It's apparent that
system_cc_heap users don't care about it being a module while system
heap users would very much like so.

I also discussed this with Arnd, and he suggested we could rearrange
the code so that system_heap_cc_shared_priv depends on a new Kconfig
symbol like

config DMABUF_HEAPS_CC_SYSTEM
        bool "DMA-BUF System Heap for memory encryption"
        depends on ARCH_HAS_MEM_ENCRYPT && DMABUF_HEAPS_SYSTEM=y

This allows building both into the kernel or leave encryption choice
up to the consumers of the system heap.

If this is agreeable to everyone, I can post Arnd's patch.

>
> Jason


Best,
Sumit.
