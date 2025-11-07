Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47052304BC1
	for <linux-s390@vger.kernel.org>; Fri,  7 Nov 2025 10:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762511250; cv=none; b=rx7epsgvuz56axWG9WaOcoVFyTBBwWzQbqAz8pgSC54n/Iu8izgP8HHLwjCFtHlED77FDV+ubDEK9+n5kiCs5Ffu5uQt+lflcNs7rDKU88t+4hWqpXZagluqL7QZF9p4uBEc1VIlz4pjmpX1AF8WlH205+/Ys/1WfFTMuaHTDMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762511250; c=relaxed/simple;
	bh=dU6O56OMghwZS1aR5LvfSCdFf1Qmv6aFo7OI83fsuug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HNNaPobeauhwISVCzYbQjT3l5IsLjyJ8hm2SodD2IX7pJylGs0ICjcj5UZnTAxwlk47LJahAlYg+lTXGwFkodxtTmW5ysNV3M4nOgolTzYnWmyAlpdHQjvJgHf1aYyFzuLn2hMwWnoS+It69utkUiM+YtEtHVMJp3d/5HlMiyUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D1eEq/LZ; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D1eEq/LZ"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-880439c5704so5136106d6.1
        for <linux-s390@vger.kernel.org>; Fri, 07 Nov 2025 02:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762511247; x=1763116047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLhtIptgftMWRvfp8mRlQOiL9wA5G5qSa8Z4beNB3RU=;
        b=D1eEq/LZcAtvr34DcXGrFwh+SfW7gJYg1bCxxiPskhGA02RPtqnLl1+R44u7NhAQes
         5x0bPj7INeArCh83PYN9OGlI2pCnJRxsJWeLFJsNeNTd32Mo6ZCu+cgUHGedt7O9gLDZ
         eUGl8sFDhKhI/4/4+7GLDjHSPA8bg6BjzBgArW68kTpTKQ0i5BQki1bdbVNrOTMQLY+5
         vYHsC9H6Oq2u2VFwrlzpqwDpfaujqjo6UhuwdRDpUPdPg6/EQNeCHPnJYBG1zZwmBim6
         JDaBcoDaT7a0L1/yC82G6kzzv35yFrJS8SraaeTOFqTN4RwxU3TbMipGCAImB+hH4Wb1
         45EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762511247; x=1763116047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pLhtIptgftMWRvfp8mRlQOiL9wA5G5qSa8Z4beNB3RU=;
        b=wmahe6lZW2lRCuYiQmngcSH/+6xIIF8/QEBF0BRoWsuMMkbGBEZBMSxJaXUmr9VR3z
         ygd1VuXR0hFmL1SoM251M6cfTax6mcSoRHyOnjHq5b7ARoMgUgdBFMyBsD53G2vXAvza
         TioXPDw++aHEahwuzx3N/7cGh8Tky3EhtusB1G8mVVh7cPKnRW3Bg/jtVSDe2acZ9O8P
         LAXarXeokBrQCwW1lVp8dPIx+dGbBSoI1ISHhe6unp3SFoEU9L4FZLdlVTf3VeV86yib
         F6dZ8eWRnjJGHG07mPljE/1RSy7IyPhmtCo1UuHc4A15v478Px4+c2IGsCghIlWcCdx0
         OfLA==
X-Forwarded-Encrypted: i=1; AJvYcCVnmfCuKt1gd23ArYluZgjaxTK3fjXPw70xAYryhYQWJYxziJ5zAYDwTHJg7xmAUUmYLTU3oJHTRSwi@vger.kernel.org
X-Gm-Message-State: AOJu0YxcqF1GWshYfW1NzAfITgNT3CUiaiD/IQdc3zwLLbL5691DN50P
	2sCTrlQ3l/OmqxHkkcdivWw3sZ8gfYIPqxYSZQBiSU7pu4MtJmQ7o2E5o3D77KUvQxyZ7XhPlFv
	HqYbhpanuAGu+cYVcFRjjGS7KxO2DGfBrGj+J5dZC
X-Gm-Gg: ASbGncsWriz/PD4NE1K76Ey/4t+WemRw5iq81St/G8O8tPGJifZAN+RsRlSyspn0MLQ
	iou4ilJ9X1oIVHa9yD8PFzcB/ZDFtymQYPxJAsg7eLysI1Ess0THl7UcCDJcM5xwDk4p6x1hhVo
	TTEk7meu4gQ9QSFMR2re82Ox1NjWDEVsYxBM9UGrPWhjFSMICgTSpwp2N//nYeZaBrknKoxfpXE
	oop2GGiYfHCHmoLVUSrMl+Ya8Oq31ueV9ZaVwuLO3PXVUdrm0OjyIPYdJdhccEQGEqfr6ByMqyD
	Oz0cWF6HxtVvS5jYvzVPtNeo9g==
X-Google-Smtp-Source: AGHT+IHGzRF/1cbs/MsDVPOx8UJ49URwz8VUyR081sUbxE8+sqheDOB1N7EBEDuZ+mpR05WsdF19S4wEHS/n0A2MIu0=
X-Received: by 2002:ad4:5e8c:0:b0:87c:fbf:108a with SMTP id
 6a1803df08f44-88167afbb01mr33443336d6.10.1762511246798; Fri, 07 Nov 2025
 02:27:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106160845.1334274-2-aleksei.nikiforov@linux.ibm.com> <20251106160845.1334274-6-aleksei.nikiforov@linux.ibm.com>
In-Reply-To: <20251106160845.1334274-6-aleksei.nikiforov@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 7 Nov 2025 11:26:50 +0100
X-Gm-Features: AWmQ_bnF17f6A18RySh-hO3pa-QL803fyOZqBKR4ZjbBOIO0pB_5mi0dYohMDnE
Message-ID: <CAG_fn=WufanV2DAVusDvGviWqc6woNja-H6WAL5LNgAzeo_uKg@mail.gmail.com>
Subject: Re: [PATCH 2/2] s390/fpu: Fix kmsan in fpu_vstl function
To: Aleksei Nikiforov <aleksei.nikiforov@linux.ibm.com>
Cc: Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
	Juergen Christ <jchrist@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 5:09=E2=80=AFPM Aleksei Nikiforov
<aleksei.nikiforov@linux.ibm.com> wrote:
>
> clang generates call to __msan_instrument_asm_store with 1 byte as size.
> Manually call kmsan helper to indicate correct amount of bytes written.
>
> If function fpu_vstl is called with argument 'index' > 0,
> it writes at least 2 bytes, but kmsan only marks first byte as written.
>
> This change fixes following kmsan reports:
>
> [   36.563119] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   36.563594] BUG: KMSAN: uninit-value in virtqueue_add+0x35c6/0x7c70
> [   36.563852]  virtqueue_add+0x35c6/0x7c70
> [   36.564016]  virtqueue_add_outbuf+0xa0/0xb0
> [   36.564266]  start_xmit+0x288c/0x4a20
> [   36.564460]  dev_hard_start_xmit+0x302/0x900
> [   36.564649]  sch_direct_xmit+0x340/0xea0
> [   36.564894]  __dev_queue_xmit+0x2e94/0x59b0
> [   36.565058]  neigh_resolve_output+0x936/0xb40
> [   36.565278]  __neigh_update+0x2f66/0x3a60
> [   36.565499]  neigh_update+0x52/0x60
> [   36.565683]  arp_process+0x1588/0x2de0
> [   36.565916]  NF_HOOK+0x1da/0x240
> [   36.566087]  arp_rcv+0x3e4/0x6e0
> [   36.566306]  __netif_receive_skb_list_core+0x1374/0x15a0
> [   36.566527]  netif_receive_skb_list_internal+0x1116/0x17d0
> [   36.566710]  napi_complete_done+0x376/0x740
> [   36.566918]  virtnet_poll+0x1bae/0x2910
> [   36.567130]  __napi_poll+0xf4/0x830
> [   36.567294]  net_rx_action+0x97c/0x1ed0
> [   36.567556]  handle_softirqs+0x306/0xe10
> [   36.567731]  irq_exit_rcu+0x14c/0x2e0
> [   36.567910]  do_io_irq+0xd4/0x120
> [   36.568139]  io_int_handler+0xc2/0xe8
> [   36.568299]  arch_cpu_idle+0xb0/0xc0
> [   36.568540]  arch_cpu_idle+0x76/0xc0
> [   36.568726]  default_idle_call+0x40/0x70
> [   36.568953]  do_idle+0x1d6/0x390
> [   36.569486]  cpu_startup_entry+0x9a/0xb0
> [   36.569745]  rest_init+0x1ea/0x290
> [   36.570029]  start_kernel+0x95e/0xb90
> [   36.570348]  startup_continue+0x2e/0x40
> [   36.570703]
> [   36.570798] Uninit was created at:
> [   36.571002]  kmem_cache_alloc_node_noprof+0x9e8/0x10e0
> [   36.571261]  kmalloc_reserve+0x12a/0x470
> [   36.571553]  __alloc_skb+0x310/0x860
> [   36.571844]  __ip_append_data+0x483e/0x6a30
> [   36.572170]  ip_append_data+0x11c/0x1e0
> [   36.572477]  raw_sendmsg+0x1c8c/0x2180
> [   36.572818]  inet_sendmsg+0xe6/0x190
> [   36.573142]  __sys_sendto+0x55e/0x8e0
> [   36.573392]  __s390x_sys_socketcall+0x19ae/0x2ba0
> [   36.573571]  __do_syscall+0x12e/0x240
> [   36.573823]  system_call+0x6e/0x90
> [   36.573976]
> [   36.574017] Byte 35 of 98 is uninitialized
> [   36.574082] Memory access of size 98 starts at 0000000007aa0012
> [   36.574218]
> [   36.574325] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G    B      =
      N  6.17.0-dirty #16 NONE
> [   36.574541] Tainted: [B]=3DBAD_PAGE, [N]=3DTEST
> [   36.574617] Hardware name: IBM 3931 A01 703 (KVM/Linux)
> [   36.574755] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> [   63.532541] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   63.533639] BUG: KMSAN: uninit-value in virtqueue_add+0x35c6/0x7c70
> [   63.533989]  virtqueue_add+0x35c6/0x7c70
> [   63.534940]  virtqueue_add_outbuf+0xa0/0xb0
> [   63.535861]  start_xmit+0x288c/0x4a20
> [   63.536708]  dev_hard_start_xmit+0x302/0x900
> [   63.537020]  sch_direct_xmit+0x340/0xea0
> [   63.537997]  __dev_queue_xmit+0x2e94/0x59b0
> [   63.538819]  neigh_resolve_output+0x936/0xb40
> [   63.539793]  ip_finish_output2+0x1ee2/0x2200
> [   63.540784]  __ip_finish_output+0x272/0x7a0
> [   63.541765]  ip_finish_output+0x4e/0x5e0
> [   63.542791]  ip_output+0x166/0x410
> [   63.543771]  ip_push_pending_frames+0x1a2/0x470
> [   63.544753]  raw_sendmsg+0x1f06/0x2180
> [   63.545033]  inet_sendmsg+0xe6/0x190
> [   63.546006]  __sys_sendto+0x55e/0x8e0
> [   63.546859]  __s390x_sys_socketcall+0x19ae/0x2ba0
> [   63.547730]  __do_syscall+0x12e/0x240
> [   63.548019]  system_call+0x6e/0x90
> [   63.548989]
> [   63.549779] Uninit was created at:
> [   63.550691]  kmem_cache_alloc_node_noprof+0x9e8/0x10e0
> [   63.550975]  kmalloc_reserve+0x12a/0x470
> [   63.551969]  __alloc_skb+0x310/0x860
> [   63.552949]  __ip_append_data+0x483e/0x6a30
> [   63.553902]  ip_append_data+0x11c/0x1e0
> [   63.554912]  raw_sendmsg+0x1c8c/0x2180
> [   63.556719]  inet_sendmsg+0xe6/0x190
> [   63.557534]  __sys_sendto+0x55e/0x8e0
> [   63.557875]  __s390x_sys_socketcall+0x19ae/0x2ba0
> [   63.558869]  __do_syscall+0x12e/0x240
> [   63.559832]  system_call+0x6e/0x90
> [   63.560780]
> [   63.560972] Byte 35 of 98 is uninitialized
> [   63.561741] Memory access of size 98 starts at 0000000005704312
> [   63.561950]
> [   63.562824] CPU: 3 UID: 0 PID: 192 Comm: ping Tainted: G    B         =
   N  6.17.0-dirty #16 NONE
> [   63.563868] Tainted: [B]=3DBAD_PAGE, [N]=3DTEST
> [   63.564751] Hardware name: IBM 3931 A01 703 (KVM/Linux)
> [   63.564986] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Fixes: dcd3e1de9d17 ("s390/checksum: provide csum_partial_copy_nocheck()"=
)
> Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Aleksei Nikiforov <aleksei.nikiforov@linux.ibm.com>
> ---
>  arch/s390/include/asm/fpu-insn.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/s390/include/asm/fpu-insn.h b/arch/s390/include/asm/fpu=
-insn.h
> index 135bb89c0a89..151b17e22923 100644
> --- a/arch/s390/include/asm/fpu-insn.h
> +++ b/arch/s390/include/asm/fpu-insn.h
> @@ -393,6 +393,7 @@ static __always_inline void fpu_vstl(u8 v1, u32 index=
, const void *vxr)
>                      : [vxr] "=3DQ" (*(u8 *)vxr)
>                      : [index] "d" (index), [v1] "I" (v1)
>                      : "memory");
> +       instrument_write_after(vxr, size);
>  }
>
>  #else /* CONFIG_CC_HAS_ASM_AOR_FORMAT_FLAGS */
> @@ -409,6 +410,7 @@ static __always_inline void fpu_vstl(u8 v1, u32 index=
, const void *vxr)
>                 : [vxr] "=3DR" (*(u8 *)vxr)
>                 : [index] "d" (index), [v1] "I" (v1)
>                 : "memory", "1");
> +       instrument_write_after(vxr, size);
>  }

Wouldn't it be easier to just call kmsan_unpoison_memory() here directly?
