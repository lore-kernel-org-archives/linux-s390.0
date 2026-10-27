Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793115323;
	b=b5J+j3EghUUfEwLFGWPwGfHBpH6jWX5i/swfMXnTmr+Xo+9WMd85srfIA5IhJtnciB7t
	 Yf8XjzMAFo+ZtnONrDHeZ2WS96JKD+vp0OAeDF8t2+DOFTDUG3PeOsnkvSkjh02ZJqvhX
	 +JuMoTLo+IY22GvsUf+j0HLIXPYX/lVD3Y5J9K2jdP1PsnIq/MH8OZU0F4z5EbwbvFvfx
	 PUpIWkm4WHG/zGDKeNLSIkp59HiIX6/XWeq2i8/o8KfBDwCkE8D20SdYKXskX93kaSC5C
	 KT7/Lj+ESE/E3tevfpMlEteTJU3XUgLnVpETVE2j636vScGoqUVRYGks609OBQx6nkA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793115323;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=4zAei5lThhZDw5YSnMo1UVcmXVNHUE0mRv/Yv8V16b4=;
	b=cJAwvWXeQS7M6mY565z1m+gkne6kt+APYG9BekvAcUOcFeBlNRwMtqlQzxXVmXUTkEob
	 Sgev/uuObv+R7mHMxYpwa9SWwuozbF5ao93R3D8xkVNtix4/98DtjyVwnRk43mhBR0MNF
	 38Yae31TZdJ8KnaF26XberCKHKcrVJPkrI+nyFsSDqQfSGTSMRf8QMv6WHtgEfZeNw/vQ
	 7RrbAZLCOPaAAraebREpLHyyBwVTEx18zTErXtx50nHjeySSJVcXj3kpOoKhWv+93aLTv
	 8JY015lJDzLngONVFRamcDkc4i8oFTlozLNIJf89q1MsZinCKTninhHN00acN5KN/oQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jF+A3FID;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CF8606A31E
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 15:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91CF8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jF+A3FID
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6ae15688f36so4197a12.1
        for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 08:35:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793115321; cv=none;
        d=google.com; s=arc-20260327;
        b=Ve7635mC5towdgDldd+uSsGb521MecYJ3ksmW/tmCkMdtxEj0m4w2RrjZ1J6leyhQV
         SBRv6o9jQCe/XfTPnOCcmH12hT2ahaxZJQDZkv8M4teIPPB78NMo5UiWxAFaUbxdOc6o
         dPa2/XFEz/nmZIchNVQ7vzVLirzY6rEur9J2xOTeAsMKPYQj6+uf36WHBUKOC7NMRhuw
         3NxR7LDAtVRmxiwKFHy+yEaeODOt6vW5JIYf1AEDHvqWHpw+uALcfoFsXRoZv8v+fr09
         NQqJdWgfxDbL5v4HzJaMRmRFLvM5Ut+J1vItcJ7tIrmrcM6oUBr4hHnBYwtNKNGr82Hx
         2H2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4zAei5lThhZDw5YSnMo1UVcmXVNHUE0mRv/Yv8V16b4=;
        fh=DiyL7i9IAT0etCoubIkFT5FSKUaA5JbRjy8K3uoU31g=;
        b=hM5Gm80/e+A45FbEqNWggGdTBcEzNffbgjQdXNDR3pRTpMrMBacWjiSCnlZQV2cTK7
         KhsFfF3ZV8M3NEuRGrgwX/i1bNR+QfM+v6FNzHnPz/aOoK606ZKYYmB3Voeov/etyYjN
         QQUZ8Oi7YWsGzHc+8a0fn+Nz6h46+D0u6klykNYhWNdJlsN/aRwfEQzwhqXr6MEZcHcb
         I1WXJwt9uFKrpuTr5McDoAQSEun1sWYsvP4GjNRj6foQsHnWStQTtFUMCc3o1/awn8pp
         WuHKxV3jOcjePLynrMugUR+1Efs32pizbc5ZI6vdBR1QiIRrX3fkfxpXS9AVZ8ErHzCz
         HV1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793115321; x=1793720121; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4zAei5lThhZDw5YSnMo1UVcmXVNHUE0mRv/Yv8V16b4=;
        b=jF+A3FID7MCXLkbFOXlV2Qyb9mzjvWlVy6WXQCmEmtj76wEKreA2uZB1KMUiqNWF/H
         lIFmGXjlNVRVN9NSqSTt9XGHfID96Cu/pg90x1+BPtQoDNSArLOImp8KMZY+Z6+4ifen
         iBHTMnXp39uelX99Q1EudMGM4N1DT8pm8DQpV7uGx07v3EI3eguBu45dCS6g44/EK8f7
         14/KnK7Ir84Vq04idf6TLM/HAb5o6rRt68Za4YS4TWXAlAy9JMZtkph1KOQSF5hMecTL
         NjBBPXq6cy97hTPH0OMLu4yIYVjqnM1j+Jhlz4qn7WpQrAjabdu2CH4YAwJbge6PhFKj
         og1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793115321; x=1793720121;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4zAei5lThhZDw5YSnMo1UVcmXVNHUE0mRv/Yv8V16b4=;
        b=NrxbTabeGzw4dDOzq9l/8MoaVsQlgEbw+vRJsIYf3enx1qBUDX2MV555PPc5L5sFmx
         NwiACd3/ue19BfIiLhJtQ5PglaObKDDyEqVZLJPMpDkAj/f4iF3VFxeeZ+o2X1I0nkpo
         ul64AulGi6nSD8o+DJ4+5MwkcsacEwbKlaEZKU4/VVtJiyu0pU5Zk3zNtzV+UzSBg9Rt
         E6hhH2R5UYtO8bATJrD/a7kFiFdsomiNgNodo3koXlG7emiYGnE/nEH0oKjhcSIO6QZO
         v4maf3Q7dQ71fTNyEEEBdXbEU6EWz04Kp+vEQvMdd5P2RRKs8g5dNYoDcBm1GeyJSe0i
         HmFA==
X-Forwarded-Encrypted: i=1; AKwUvBy+35leuWNXQyc574QY8Noe7c5kwqjLAR4k+V+JDjfDgT6PXhYFna1fqewRiN4W64RXF27pl+bg49A3@vger.kernel.org
X-Gm-Message-State: AFq9FYJD+QJzI5Q42zu1qw2DEYLEwrMKBWkl5XLH9WPrEk1hIpkfkfDa
	EmEnfrjp3ekPVhN6hZImx8TSpwq2KXiYSCeVebY6RAg1ynWTW88zUS0xBYILzgE2G5J3qgXRGYZ
	npuznkk9UMbRQCYlI1gWuTHvQNOrXCvw=
X-Gm-Gg: AYBFou14djLI9ZlIdB+St/dUGRDnU6iboW0UWJ4MT6RBTYY/m5N8rEgz3c5Nh5mUb5K
	EeOs4yFR8q+K4jjUnQh4Ht4LguEz6geeD6UVuJHBS+PzfCRsQDXNwdbucubLSr/25n8QvdXfjA8
	LpyFVow4ysj5xAYjF7WlhRyAmqiHVFWaSBUIYAP5JOQRGGbfm69AQb36/yK2vFk4CHIH9axuirl
	15rGkey5AL3wp/AsIipOpZVH+NK5yImHmpcSruCZtJZARWd3pmLG+h3eJTrr0eetmlUY3OvTrHi
	fystZCr8pr5P8ErFt0qS8E7dYlJ1ATocpRaa+4yRqa8ntfehzhlv5MkJwsRvy2kTR189xl3HrWy
	+gVR66gUrBnz8pQzOYJvjn9ap+Qvzi/NHKr5Nt4zPeBUY8FgqiLETtCaRVbdeL4i6tA==
X-Received: by 2002:a05:6402:a591:10b0:6b1:bc80:4167 with SMTP id
 4fb4d7f45d1cf-6b442ffe55dmr12581939a12.3.1793115320688; Tue, 27 Oct 2026
 08:35:20 -0700 (PDT)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261013091716.1210420-1-nicoyip.dev@gmail.com>
 <20261013091716.1210420-3-nicoyip.dev@gmail.com> <atisUaV2eIC2yTvX@linux.alibaba.com>
 <CAAo+4rXas4BS85yfiDSPvDhzpWkjoKBiZSHn9VeV0VcATTO0Aw@mail.gmail.com> <auCKK_VoWfbT0YH5@linux.alibaba.com>
In-Reply-To: <auCKK_VoWfbT0YH5@linux.alibaba.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Tue, 27 Oct 2026 23:35:09 +0800
X-Gm-Features: AclHuK-q6wzo-d_UnijBgtiQqSa3gBQpSahxHf2XxIrV5y5aVuwki9XzpCI4K9g
Message-ID: <CAAo+4rXn=Jbi+8yxz0=G=7-Jgx1s13AsNNXmzkhGcGdLMQuxUw@mail.gmail.com>
Subject: Re: [PATCH net v3 2/3] net/smc: serialize early link group cleanup
 with termination
To: dust.li@linux.alibaba.com
Cc: alibuda@linux.alibaba.com, sidraya@linux.ibm.com, mjambigi@linux.ibm.com, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 7:25=E2=80=AFPM Dust Li <dust.li@linux.alibaba.com>=
 wrote:
>
> On 2026-10-27 19:16:26, Chengfeng Ye wrote:
> >Hi Dust,
> >
> >Sorry for the late reply.
> >
> >On Wed, Oct 21, 2026 at 8:13=E2=80=AFPM Dust Li <dust.li@linux.alibaba.c=
om> wrote:
> >>
> >> On 2026-10-13 17:17:15, Chengfeng Ye wrote:
> >> >smc_lgr_cleanup_early() enters __smc_lgr_terminate() even when anothe=
r
> >> >teardown path has already claimed lgr->freeing. Both callers can obse=
rve
> >> >lgr->terminating clear before either sets it, then tear down the same
> >> >link group, causing use-after-free and duplicate resource release.
> >> >
> >> >  BUG: KASAN: use-after-free in __smc_lgr_terminate+0x393/0x3a0
> >> >  Write of size 1 at addr ffff8880bf2c0300 by task poc/106
> >> >  Call Trace:
> >> >   __smc_lgr_terminate+0x393/0x3a0
> >> >   __smc_connect+0x2e3d/0x4930
> >> >   smc_connect+0x42c/0x580
> >> >   __sys_connect+0xfc/0x130
> >> >   __x64_sys_connect+0x6d/0xb0
> >> >
> >> >Check freeing under the link group list lock before unlinking the gro=
up
> >> >or entering termination. The existing locked freeing transition then
> >> >claims exclusive teardown ownership; an early cleanup that loses the
> >> >claim leaves teardown to the existing owner and does not remove the g=
roup
> >> >from a device teardown's private list.
> >> >
> >> >Keep a temporary link group reference across smc_conn_free() and earl=
y
> >> >cleanup in smc_conn_abort(). Once the connection is unregistered, a
> >> >termination worker can finish without taking its socket lock. The ext=
ra
> >> >reference keeps the allocation alive until the ownership check return=
s.
> >> >
> >> >A new group is published before its first connection is registered. H=
old
> >> >it before publication until registration or failed-registration clean=
up
> >> >finishes. The reference keeps the allocation alive, but teardown can =
still
> >> >destroy the group's resources before registration. Take the list lock
> >> >around the freeing check and first registration, nesting conns_lock a=
s in
> >> >the reuse path. Reject a group already claimed for teardown and clear
> >> >conn->lgr, since that connection never acquired a group reference.
> >> >
> >> >On success, acquire the connection reference before dropping the temp=
orary
> >> >hold. A later terminator sees the registered connection and must acqu=
ire
> >> >its socket lock before removing it. On failure, keep the temporary ho=
ld
> >> >through early cleanup and then release it. Reused groups retain their
> >> >existing reference protocol.
> >> >
> >> >This depends on "net/smc: serialize link group free work scheduling" =
for
> >> >the standalone freeing bool and the locked early-cleanup transition.
> >> >
> >> >Fixes: f9aab6f2ce57 ("net/smc: immediate freeing in smc_lgr_cleanup_e=
arly()")
> >> >Cc: stable@vger.kernel.org
> >> >Assisted-by: GPT-6.1-Sol
> >> >Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> >> >---
> >> >Changes in v3:
> >> >- Serialize first registration with the teardown claim under the grou=
p list
> >> >  lock, nesting conns_lock in the same order as connection reuse.
> >> >- Reject groups already being freed and clear conn->lgr on that path.
> >> >- Document the scheduling fix prerequisite in the permanent commit me=
ssage.
> >> >
> >> >Changes in v2:
> >> >- Pin newly created link groups before publication, covering the
> >> >  registration failure handoff to early cleanup. Drop the temporary h=
old
> >> >  after cleanup on failure, or after the connection hold on success.
> >> >- Send after the free-work scheduling fix and reuse its standalone
> >> >  freeing bool and locked early-cleanup transition.
> >> >- Pin the link group across the smc_conn_abort() early-cleanup owners=
hip
> >> >  check.
> >> >
> >> >v1: https://lore.kernel.org/r/20260927063607.3691520-1-nicoyip.dev@gm=
ail.com/
> >> >
> >> >v2: https://lore.kernel.org/r/20261003183237.2284245-3-nicoyip.dev@gm=
ail.com/
> >> >
> >> > net/smc/af_smc.c   |  8 ++++++--
> >> > net/smc/smc_core.c | 21 ++++++++++++++++++---
> >> > 2 files changed, 24 insertions(+), 5 deletions(-)
> >> >
> >> >diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> >> >index e9f93b3ab435..97b0a0b51066 100644
> >> >--- a/net/smc/af_smc.c
> >> >+++ b/net/smc/af_smc.c
> >> >@@ -1011,12 +1011,16 @@ static void smc_conn_abort(struct smc_sock *s=
mc, int local_first)
> >> >       struct smc_link_group *lgr =3D conn->lgr;
> >> >       bool lgr_valid =3D false;
> >> >
> >> >-      if (smc_conn_lgr_valid(conn))
> >> >+      if (local_first && smc_conn_lgr_valid(conn)) {
> >> >               lgr_valid =3D true;
> >> >+              smc_lgr_hold(lgr);
> >> >+      }
> >> >
> >> >       smc_conn_free(conn);
> >> >-      if (local_first && lgr_valid)
> >> >+      if (lgr_valid) {
> >> >               smc_lgr_cleanup_early(lgr);
> >> >+              smc_lgr_put(lgr);
> >> >+      }
> >> > }
> >> >
> >> > /* check if there is a rdma device available for this connection. */
> >> >diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> >> >index 660cd41ec720..c1bb284c4233 100644
> >> >--- a/net/smc/smc_core.c
> >> >+++ b/net/smc/smc_core.c
> >> >@@ -693,6 +693,10 @@ void smc_lgr_cleanup_early(struct smc_link_group=
 *lgr)
> >> >
> >> >       smc_lgr_list_head(lgr, &lgr_lock);
> >> >       spin_lock_bh(lgr_lock);
> >> >+      if (lgr->freeing) {
> >> >+              spin_unlock_bh(lgr_lock);
> >> >+              return;
> >> >+      }
> >> >       /* do not use this link group for new connections */
> >> >       if (!list_empty(&lgr->list))
> >> >               list_del_init(&lgr->list);
> >> >@@ -999,6 +1003,7 @@ static int smc_lgr_create(struct smc_sock *smc, =
struct smc_init_info *ini)
> >> >               lgr->buf_type =3D lgr->net->smc.sysctl_smcr_buf_type;
> >> >               atomic_inc(&lgr_cnt);
> >> >       }
> >> >+      smc_lgr_hold(lgr); /* lgr_put in smc_conn_create() */
> >> >       smc->conn.lgr =3D lgr;
> >> >       spin_lock_bh(lgr_lock);
> >> >       list_add_tail(&lgr->list, lgr_list);
> >> >@@ -2049,15 +2054,25 @@ int smc_conn_create(struct smc_sock *smc, str=
uct smc_init_info *ini)
> >> >               if (rc)
> >> >                       goto out;
> >> >               lgr =3D conn->lgr;
> >> >-              write_lock_bh(&lgr->conns_lock);
> >> >-              rc =3D smc_lgr_register_conn(conn, true);
> >> >-              write_unlock_bh(&lgr->conns_lock);
> >> >+              spin_lock_bh(lgr_lock);
> >> >+              if (lgr->freeing) {
> >> >+                      conn->lgr =3D NULL;
> >> >+                      rc =3D SMC_CLC_DECL_SYNCERR;
> >>
> >> This should not be SMC_CLC_DECL_SYNCERR, maybe SMC_CLC_DECL_INTERR or =
add
> >> a new error code.
> >
> >No problem, I will use SMC_CLC_DECL_INTERR in v4.
> >
> >> >+              } else {
> >> >+                      write_lock_bh(&lgr->conns_lock);
> >> >+                      rc =3D smc_lgr_register_conn(conn, true);
> >> >+                      write_unlock_bh(&lgr->conns_lock);
> >> >+              }
> >> >+              spin_unlock_bh(lgr_lock);
> >> >               if (rc) {
> >> >                       smc_lgr_cleanup_early(lgr);
> >> >+                      smc_lgr_put(lgr); /* lgr_hold in smc_lgr_creat=
e() */
> >>
> >> smc_lgr_put() may call smcr_buf_free() -> vfree(), which may sleep.
> >> And you put it in the spinlock.
> >
> >It seems the smc_lgr_put(lgr) is added after the
> >spin_unlock_bh(lgr_lock). Were you referring to another lock held by a
> >caller? I will keep this unchanged in v4, let me know if anything
> >should be adjusted further.
>
> No, I mean this part in [PATCH net v3 3/3], sorry for replying to the wro=
ng thread.

Thanks for the clarification. The smc_lgr_put(lgr) only calls the
vfree() when the refcount reaches zero. I check the caller of
smc_lgr_schedule_free_work() and it is only called from
smc_conn_free(), and already hold a refcount. Furthermore, the added
smc_lgr_put(lgr) also balances with the additional smc_lgr_hold(), so
before smc_lgr_put(lgr) execution the refcount is at least 2 and will
not call into the vfree().

We can also make the smc_lgr_put() outside the spinlock region, just
that the code will look like the following, which is a bit more messy
(one extra if branch after unlock). An alternative is that we could
keep the v3 and add extra comments above smc_lgr_schedule_free_work()
like indicating the refcount it at least 1. Please let me know which
you prefer and I will send the v4.

        if (!lgr->freeing) {
-               mod_delayed_work(system_percpu_wq, &lgr->free_work,
-                                (!lgr->is_smcd && lgr->role =3D=3D SMC_CLN=
T) ?
-                                               SMC_LGR_FREE_DELAY_CLNT :
-                                               SMC_LGR_FREE_DELAY_SERV);
+               smc_lgr_hold(lgr); /* released by the worker or cancellatio=
n */
+               pending =3D mod_delayed_work(system_percpu_wq, &lgr->free_w=
ork,
+                                          (!lgr->is_smcd && lgr->role
=3D=3D SMC_CLNT) ?
+                                                  SMC_LGR_FREE_DELAY_CLNT =
:
+                                                  SMC_LGR_FREE_DELAY_SERV)=
;
        }
+       spin_unlock_bh(lgr_lock);
+       if (pending)
+               smc_lgr_put(lgr); /* pending work already owns a reference =
*/


>
> @@ -89,14 +89,22 @@ static void smc_lgr_schedule_free_work(struct smc_lin=
k_group *lgr)
>          * otherwise there is a risk of out-of-sync link groups.
>          */
>         if (!lgr->freeing) {
> -               mod_delayed_work(system_percpu_wq, &lgr->free_work,
> -                                (!lgr->is_smcd && lgr->role =3D=3D SMC_C=
LNT) ?
> -                                               SMC_LGR_FREE_DELAY_CLNT :
> -                                               SMC_LGR_FREE_DELAY_SERV);
> +               smc_lgr_hold(lgr); /* released by the worker or cancellat=
ion */
> +               if (mod_delayed_work(system_percpu_wq, &lgr->free_work,
> +                                    (!lgr->is_smcd && lgr->role =3D=3D S=
MC_CLNT) ?
> +                                            SMC_LGR_FREE_DELAY_CLNT :
> +                                            SMC_LGR_FREE_DELAY_SERV))
> +                       smc_lgr_put(lgr); /* pending work already owns a =
reference */
>         }
>         spin_unlock_bh(lgr_lock);
>
> Best regards,
> Dust

Best regards,
Chengfeng
