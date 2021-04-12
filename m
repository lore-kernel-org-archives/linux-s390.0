Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4928BC433ED
	for <linux-s390@archiver.kernel.org>; Mon, 12 Apr 2021 10:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 232DD61249
	for <linux-s390@archiver.kernel.org>; Mon, 12 Apr 2021 10:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239267AbhDLKya (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 12 Apr 2021 06:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239661AbhDLKy3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 12 Apr 2021 06:54:29 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155D1C061574
        for <linux-s390@vger.kernel.org>; Mon, 12 Apr 2021 03:54:11 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id g35so9039283pgg.9
        for <linux-s390@vger.kernel.org>; Mon, 12 Apr 2021 03:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gJcLSZkDfq5rBKUmQZHkqxLmAY9jOIK3PpAFXDzx2H4=;
        b=uRNvWxBaZP5i9BTaqNlJt6ms1wnVkcfg9KQ2uHmSDPjSp80QsyUgf/trb30jXjkPQH
         Vih8u79fg9OrLZQv4ZF69oV8BDg7FUMdTKtG9I4alwYHRPh7uKl4fbM6iviz7mOqUPPS
         NBY6FQnVqWLYk1Q7zHGxdsT1142IuK3t/OD05AU9jFlCY27pMhoHuzpt7rBPHuiYcAAh
         6TH8zglD4JC0QL0Wr/G0o6d6gjjZew5Fq4bscMaRcWb4pShokqtb5zrU3I7Rrc199VkK
         9Yelu/cKgSyviVpTltbCoptLT81lo6jwvLgi2HAE/GCHnm2+xBmQ6WEdhqJ5Af53EcHL
         3Kkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gJcLSZkDfq5rBKUmQZHkqxLmAY9jOIK3PpAFXDzx2H4=;
        b=MNe6OoQC9PkiA9HpuRrcJZB0NQLlMZT0ClyxLKTJkMjBorz+18VOQKcXMAS14oHKUx
         cexGaUHRuhNw9ME8Gv+6hiVBuweVrh8sbaKEB1UryQyuzp/dQSC9ORYSJdnOdPkhrUeV
         2zCZw5oF7kjJxwFIelN0g8twwag0BmUPiHbdSSTLEJtlx7HNRv7SMk2/XWsVv9OpXUAI
         mSMnl+y84pJkMga1Q6YD629ok9FAoohrKjdF0rrIDo7jKxvko4UeWNL/WyCIjjn+Rg+r
         L1oVbTHZpm+HN7J7u7WxvzdReUxW3kqyhjkTGYVRPAFffqJDE4i7mUSZ+zTOK2r3+Brm
         9Ttw==
X-Gm-Message-State: AOAM533aOfp7YTWCTSu9zoS6vEJgU5nMs5Q24h1rUgw+1khVZ/LFzBEx
        lN9lpkDCjSHPOcdENND/rgPk9Pak1UnxHn20tZlVmA==
X-Google-Smtp-Source: ABdhPJzClVIzuZZWh1yx/yOde1FWj70+uL2+JH5onHn4QRcFFztNbd21peFA77PwJSb986fPaQ9RBDBS0ux2Ej2BNos=
X-Received: by 2002:a65:6645:: with SMTP id z5mr25668077pgv.273.1618224850627;
 Mon, 12 Apr 2021 03:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210401030141.37061-1-songmuchun@bytedance.com> <4b9c1b0c-00dc-97e0-0e17-b8467c4cb31d@de.ibm.com>
In-Reply-To: <4b9c1b0c-00dc-97e0-0e17-b8467c4cb31d@de.ibm.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 12 Apr 2021 18:53:33 +0800
Message-ID: <CAMZfGtVyKCdWKcY5wCwD+ocVy9JADJwgRs12vh4sbL3s8oRx9A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: memcontrol: fix forget to obtain the
 ref to objcg in split_page_memcg
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com,
        linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Apr 12, 2021 at 6:42 PM Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
>
> FWIW, I was away the last week, and I checked yesterdays next (e99d8a8495=
17) regression runs.
> I still do see errors in our CI system:
>
> [ 2263.021681] ------------[ cut here ]------------
> [ 2263.021697] percpu ref (obj_cgroup_release) <=3D 0 (0) after switching=
 to atomic
> [ 2263.021748] WARNING: CPU: 4 PID: 0 at lib/percpu-refcount.c:196 percpu=
_ref_switch_to_atomic_rcu+0x1ea/0x1f8
> [ 2263.021756] Modules linked in: scsi_debug vfio_pci irqbypass vfio_virq=
fd kvm vhost_vsock vmw_vsock_virtio_transport_common vsock vhost vhost_iotl=
b xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT xt_tcpudp nft_compat nf=
_nat_tftp nft_objref nf_conntrack_tftp nft_counter bridge stp llc nft_fib_i=
net nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_rej=
ect_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6=
 nf_defrag_ipv4 ip_set nf_tables nfnetlink dm_service_time zfcp scsi_transp=
ort_fc dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua rpcrdma sunrpc rd=
ma_ucm rdma_cm iw_cm ib_cm mlx5_ib dm_mod ib_uverbs ib_core s390_trng vfio_=
ccw vfio_mdev mdev vfio_iommu_type1 vfio eadm_sch zcrypt_cex4 sch_fq_codel =
configfs ip_tables x_tables ghash_s390 prng aes_s390 des_s390 libdes sha3_5=
12_s390 sha3_256_s390 mlx5_core sha512_s390 sha256_s390 sha1_s390 sha_commo=
n nvme nvme_core pkey zcrypt rng_core autofs4 [last unloaded: vfio_ap]
> [ 2263.021820] CPU: 4 PID: 0 Comm: swapper/4 Not tainted 5.12.0-20210412.=
rc6.git0.e99d8a849517.300.fc33.s390x+next #1
> [ 2263.021823] Hardware name: IBM 8561 T01 703 (LPAR)
> [ 2263.021825] Krnl PSW : 0704c00180000000 000000025b234c1e (percpu_ref_s=
witch_to_atomic_rcu+0x1ee/0x1f8)
> [ 2263.021829]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 P=
M:0 RI:0 EA:3
> [ 2263.021832] Krnl GPRS: c0000000fffeffff 00000002f7212818 0000000000000=
042 00000000fffeffff
> [ 2263.021834]            00000000ffffffea 0000038000000001 0000000000000=
000 000003800000017c
> [ 2263.021836]            000000025b980988 00000000b774d0e0 000003fee191d=
5d8 8000000000000000
> [ 2263.021838]            000000008034c000 00000002f7227570 000000025b234=
c1a 00000380000aba28
> [ 2263.021849] Krnl Code: 000000025b234c0e: e3309fe8ff04        lg      %=
r3,-24(%r9)
>                            000000025b234c14: c0e5001ebe92        brasl   =
%r14,000000025b60c938
>                           #000000025b234c1a: af000000            mc      =
0,0
>                           >000000025b234c1e: a7f4ffcc            brc     =
15,000000025b234bb6
>                            000000025b234c22: 0707                bcr     =
0,%r7
>                            000000025b234c24: 0707                bcr     =
0,%r7
>                            000000025b234c26: 0707                bcr     =
0,%r7
>                            000000025b234c28: eb6ff0480024        stmg    =
%r6,%r15,72(%r15)
> [ 2263.021912] Call Trace:
> [ 2263.021914]  [<000000025b234c1e>] percpu_ref_switch_to_atomic_rcu+0x1e=
e/0x1f8
> [ 2263.021917] ([<000000025b234c1a>] percpu_ref_switch_to_atomic_rcu+0x1e=
a/0x1f8)
> [ 2263.021919]  [<000000025abe16fe>] rcu_do_batch+0x146/0x608
> [ 2263.021924]  [<000000025abe5ff4>] rcu_core+0x124/0x1d0
> [ 2263.021926]  [<000000025b62a222>] __do_softirq+0x13a/0x3c8
> [ 2263.021930]  [<000000025ab5d3f6>] irq_exit+0xce/0xf8
> [ 2263.021934]  [<000000025b61a5f6>] do_ext_irq+0xd6/0x160
> [ 2263.021937]  [<000000025b627c3c>] ext_int_handler+0xc4/0xf4
> [ 2263.021939]  [<0000000000000000>] 0x0
> [ 2263.021943]  [<000000025b62775a>] default_idle_call+0x42/0x110
> [ 2263.021945]  [<000000025ab99328>] do_idle+0xd8/0x168
> [ 2263.021949]  [<000000025ab99576>] cpu_startup_entry+0x36/0x40
> [ 2263.021952]  [<000000025ab1f33a>] smp_start_secondary+0x82/0x88
> [ 2263.021955] Last Breaking-Event-Address:
> [ 2263.021955]  [<000000025abc8828>] vprintk_emit+0xa8/0x110
> [ 2263.021961] Kernel panic - not syncing: panic_on_warn set ...
> [ 2263.021962] CPU: 4 PID: 0 Comm: swapper/4 Not tainted 5.12.0-20210412.=
rc6.git0.e99d8a849517.300.fc33.s390x+next #1
> [ 2263.021964] Hardware name: IBM 8561 T01 703 (LPAR)
> [ 2263.021965] Call Trace:
> [ 2263.021966]  [<000000025b60bc9a>] show_stack+0x92/0xd8
> [ 2263.021972]  [<000000025b6161c0>] dump_stack+0x90/0xc0
> [ 2263.021975]  [<000000025b60cab2>] panic+0x112/0x308
> [ 2263.021977]  [<000000025ab5571a>] __warn+0xc2/0x158
> [ 2263.021981]  [<000000025b2a5e4a>] report_bug+0xb2/0x130
> [ 2263.021984]  [<000000025ab09ef4>] monitor_event_exception+0x44/0xc0
> [ 2263.021986]  [<000000025b61a1e8>] __do_pgm_check+0xe0/0x1f0
> [ 2263.021988]  [<000000025b627b30>] pgm_check_handler+0x118/0x160
> [ 2263.021990]  [<000000025b234c1e>] percpu_ref_switch_to_atomic_rcu+0x1e=
e/0x1f8
> [ 2263.021992] ([<000000025b234c1a>] percpu_ref_switch_to_atomic_rcu+0x1e=
a/0x1f8)
> [ 2263.021993]  [<000000025abe16fe>] rcu_do_batch+0x146/0x608
> [ 2263.021995]  [<000000025abe5ff4>] rcu_core+0x124/0x1d0
> [ 2263.021997]  [<000000025b62a222>] __do_softirq+0x13a/0x3c8
> [ 2263.021998]  [<000000025ab5d3f6>] irq_exit+0xce/0xf8
> [ 2263.022000]  [<000000025b61a5f6>] do_ext_irq+0xd6/0x160
> [ 2263.022001]  [<000000025b627c3c>] ext_int_handler+0xc4/0xf4
> [ 2263.022003]  [<0000000000000000>] 0x0
> [ 2263.022004]  [<000000025b62775a>] default_idle_call+0x42/0x110
> [ 2263.022006]  [<000000025ab99328>] do_idle+0xd8/0x168
> [ 2263.022008]  [<000000025ab99576>] cpu_startup_entry+0x36/0x40
>
> So either the fix was not complete or it is still missing in next.

The fix now is on the mm-tree. I guess the branch you
tested does not contain this fix patch. You can check if
the function of obj_cgroup_get_many() exists. If it
doesn't exist, this means my guess is correct.

Thanks.
