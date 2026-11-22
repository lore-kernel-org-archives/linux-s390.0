Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795356410;
	b=jcxYo21gtLT3gZBTm3hDYYIzyKypCmiWIL0QaPU2K5G7mrznSiXcupCGemEvcmgBk/jp
	 Jk5jKl+eu/53LXgYj1WQO7Hsx0s1mvcUKA1lpwyTQGdy/Vu4Mn9TuW9gnKQRRoBH6GHpe
	 /D72mrXTBYYweooq4XE4O7LMS/Cb6L8WckIyhSCeOmasENZUL9+AUrYWqTgmo7pMkY0dK
	 /+whHoFnA7CEwcrjlrxb5VgzmVUMLBkF52JcAtknHABqbDWVZlBO9KstSy7FI++qA9lqJ
	 P208M/nwwB8ExIobZpE1YL9kjXdOTjZoxx87moJvmWW/87KA4Bb/RmdJ0s6toidX8XQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795356410;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=2P7NnlFD6hf0e/Q9nUMush5WduoVnm93NdkP6w446kQ=;
	b=j4C5Ax+6neqw4NhNdkKZw0tTNnrZaqdVQjEjmHmAn2qC3YECmlyMBfaoevPmCB0XUKa3
	 rmqmVlgKSP8xT9M7JnVDrhv/p9ebT+nHQZBM/bROcLDJNflq2LDwRPvk4A6a5p2hC0QMf
	 Ei5vgdvg+Ctnja4Eww0KIrqgDVbMWiRUvmMvTTM8qevkTjm2A01JvMXWN3FWcuZG+eMrx
	 g+Kbzd3I0xpA+EqIMr+uPvNOyFdvDl4zGaWuDZirNxkGYPUUu07oQE9sHHCv8AuFEAxnf
	 yaL3ta/pGLNOeVvLEhDFSehoNslif1x43gIsZmYM31c3zm7WH42QU9nybQJO0/XYanQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iiitd.ac.in;
	spf=pass smtp.mailfrom=iiitd.ac.in;
	dkim=pass header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=jd6ioXn8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903A3606A330
	for <linux-s390@vger.kernel.org>; Sun, 22 Nov 2026 14:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 903A3606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=jd6ioXn8
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b547d6c07bso2979135a12.1
        for <linux-s390@vger.kernel.org>; Sun, 22 Nov 2026 06:06:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795356402; cv=none;
        d=google.com; s=arc-20260327;
        b=Fy2dLiJZVt+fzEEUEYMCJ1Cs40weCM4IU6P0S5tKyJqZCRDw3ETNDHWIigNeHix7ja
         fGm3pXCNo+HWrAQR9KT1211Abho6c+4XubaRwF+5R2UOl7/Pc9ECL63D9y/hpGZWfBi8
         y4ICsCk5GoqnVJgs6UsfF0J+hRMxgUS7l0/4aIdTj1LdOVwFMUoi0MNlg9YWsnXJ8w3f
         9N+DlD16hfMU3rjqSj362NHZJp/Xy/0UpEBGDr+kxZZxvVlTYv91VVzRnAPKS0gsG1F+
         yjVnU0iLGTk6HFp/I+jE3N9v7FA6CuUhKLjvgaDEpTbSFRxIKybiR7vQ7EX3MCfK1RY6
         npIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2P7NnlFD6hf0e/Q9nUMush5WduoVnm93NdkP6w446kQ=;
        fh=ZMN4uGn4+KY2Iqpcx+Vg4p4WeSWZBxCSZp7x89QGEys=;
        b=cdxXkEWLDmnjYj+vNvp/C6oqStap3SL2wtYZ96XPyH+w7LwkievnZD85IrUPpX0/ui
         auERreAbv3F5Yj3nWJpKz1R/+N8OLFzLQ+h2cU38ygtQSzoH6mTziYL2y2shmabc9eAb
         uECMLH0ykMczTEhQ2XLaSFxBkEbd9OU0/Q3m3DrqQM+7uhnS1NKfdlO3fa9SQjnXx7lH
         zdYzdcDV4gAMXrP0aJTxufFznW+JRWeTgXlNpZS6QfH85lGSA62pf+SzluDt8KT6v6kY
         qy3gvF6deckNTS5Dkywyfbm5W7Hm6MtdpZTyJ1uNyulzsyAKCpzQa9IidFwWizCEf4Mg
         K+EQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1795356402; x=1795961202; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2P7NnlFD6hf0e/Q9nUMush5WduoVnm93NdkP6w446kQ=;
        b=jd6ioXn8/jtSW042HF6KtWbUIW3aLVlunRvtvFxC7uBtabqLQOB56p7GCu61HgF+jL
         4ERHRbTjMX6muoegMifIFXfcQpMaYLcR9pm4TCKCc9aC1Ms59nBdWl4/K4XAtvpmeVvU
         7vZ2oZxiLbMOCF+o/7WrDrg7xXGtpTH1ohREQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795356402; x=1795961202;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2P7NnlFD6hf0e/Q9nUMush5WduoVnm93NdkP6w446kQ=;
        b=ExohDJZZKp/Pz9L/AzhBGx/C1ia7kLpP7tMvWILDT07i8Gio74pacUus1TucUQn31J
         nhFmCgEzYjUbd4HDFJyIW4rtgzZT0UDlrpCUaaDomwQZ97bHVF2W/gamPz4xKRKyNaRn
         fT3M81WQe/r7juIaVWU4nQhKdZ961iJ6GxdrYNNwAZD36iC6BMg4rfBwSOBX+Uxj59a6
         j+OD/5ZfCBGZ/bxlUroOZaGGv2trEABlEgNYUJbBoL/5GMDqSYKkBowL+eDBG+aEhLKQ
         hDjbvJ+8iZgYhLEXhJWjFwzjvhnDUi/MtjzPE4mu+C1KAwjL3V63vlrcw4tZUsVgWK9+
         f4Gg==
X-Forwarded-Encrypted: i=1; AL+hErEutEy1amNeEcAHz4RB5qYYQopf/hUmyZOhCqqVazpFBQATdfxKsOimMKMoQ9PfOqhSkwSCAdk3EaXX@vger.kernel.org
X-Gm-Message-State: APuU4Z+6xkvLm9l0Ql/qtWhNzPM8WYzt7WHrgvNnWHhpP1bEPDR748WU
	X7K1hcrTII1/2m7ZPS/oqbpzsUAmj+RTD/j/BBtlEZ3OYBHBRyIdI5SEkElOv1dw6a9j60urn8O
	o2+DC51vOHKinUnVIGEEIgHwSeBqDIECdPh1pY7fSuQ==
X-Gm-Gg: AZFdTZdxNJYih53/6CBjRYNa0Uo3BJoFUBOumUWiCv4GS2e7UpCKYLNOX5dCo3FI45O
	Ea1flHgv3pQ2uqu2vMQUIzleBCckddM7Uxwil/nCsaI/Z8bG159Nb7vbCXR1bqYx5W2vc4HMInP
	dyr4U5nVqfx8/iMYYqJ7pTsNslc64zRnvNYjqL6IwOVF/lwCjLQyqbCl5YUHeH7lBQC/FmwdiGi
	Myp9kmMyiomINefI5HK35tXqaxeJY//G0vqFbhGZf13Lgzv2Y42kaiyasDE/ILWa+Xk9++OPBfc
	wbWstVhcJPvS/Bc3gi580DRMsJVZ66uMzdp1cIfzrkZMOdzQEdm/GyCDysZuDQIjHBwab23WN6u
	MkMHRmBW7zhgGSPgSCMAajXtNdd4CbjpU2PWLm2lHn+PsTyVsJvIDBBKm6Qs5uNofjtkEVXUuRa
	LBHO7vDxKKGnFL9uux9Jdy/qB9msL9RBZtpXzD+D0IuMr/kmTxKwsFlVA=
X-Received: by 2002:a05:6402:274d:b0:6ba:92c3:fef7 with SMTP id
 4fb4d7f45d1cf-6ba92c4088cmr1355074a12.19.1795356402046; Sun, 22 Nov 2026
 06:06:42 -0800 (PST)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122042120.2430434-1-piyus@iiitd.ac.in> <awLwiDzVpdJOr6BZ@linux.alibaba.com>
In-Reply-To: <awLwiDzVpdJOr6BZ@linux.alibaba.com>
From: Piyus Kedia <piyus@iiitd.ac.in>
Date: Sun, 22 Nov 2026 19:36:31 +0530
X-Gm-Features: Aa3M54pNcRlGq48LgyU0hvUMf93COD0ltrBkDDB650T83qW9BEt14_13yQ0gDU8
Message-ID: <CADq=QSyGfZBpziK7r6KD8mm1_0LRO4r4tAKe8gU52Fm-V+DHsQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net/smc: validate the peer's CDC cursors against
 our own buffers
To: dust.li@linux.alibaba.com
Cc: alibuda@linux.alibaba.com, Sidraya Jayagond <sidraya@linux.ibm.com>, 
	Mahanta Jambigi <mjambigi@linux.ibm.com>, netdev@vger.kernel.org, 
	Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kapil Vaswani <kapil@presceralabs.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dust,

Thanks for pointing this out. I checked that Bryam's patch indeed
fixes the same issue. Please drop this patch.

Best,
Piyus


On Sun, Nov 22, 2026 at 7:09=E2=80=AFPM Dust Li <dust.li@linux.alibaba.com>=
 wrote:
>
> On 2026-11-22 09:51:20, Piyus Kedia wrote:
> >A peer's CDC message carries two cursors that are offsets into buffers
> >described on this side: the producer cursor counts the bytes the peer ha=
s
> >written into the RMB we published to it, and the consumer cursor the byt=
es
> >it has taken from the RMB it published to us.  Neither is checked, on ei=
ther
> >transport.
> >
> >smcr_cdc_msg_to_host() and smcd_cdc_msg_to_host() copy both into the
> >connection as they arrive, and every later user treats them as trustwort=
hy:
> >
> > - smc_cdc_msg_recv_action() adds the producer difference to
> >   conn->bytes_to_rcv under a comment asserting
> >   "guarantee 0 <=3D bytes_to_rcv <=3D rmb_desc->len", which nothing enf=
orces;
> > - smc_cdc_handle_urg_data_arrival() reads
> >   *(base + conn->urg_curs.count - 1), an unbounded index into the RMB;
> > - smc_rx_recvmsg() clamps only the first of its two ring chunks
> >   (rmb_desc->len - cons.count) and uses the remainder unclamped for the
> >   second, so bytes_to_rcv becomes a copy length;
> > - smc_rx_splice() walks PAGE_ALIGN(len + offset) / PAGE_SIZE pages call=
ing
> >   vmalloc_to_page() without checking the result, and get_page() then
> >   dereferences NULL once the walk passes the end of the RMB.
>
> I think Bryam's patch is solving the same problem here:
> https://lore.kernel.org/netdev/20261112-b4-disp-0287c16e-v9-0-e5e8fa68817=
7@proton.me
>
> Best regards,
> Dust
>
