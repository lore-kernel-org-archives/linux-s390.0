Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793099801;
	b=jpRAQE5rPybwsHp4A8at+wAQm27/kldJt9xvnbxiWpYq1MAKYQ3kWHEcOoUtrhbrdFgV
	 qTJZUXURoKNHPCsqTrBiArDl+zXN8eaTyvnP7KgSkw6x/t0Z+Yi5qEmXLxub+3YhkfzI8
	 QeBsV44+eq8OqS4N41BTiXrwI1EG6WW8B9VnnurKK6denWd8+XZRrR51sLFYa5LrGX+nv
	 NU+KSA/5TbDm/FcxI+2/Nwx1Zo5rcHuSb0Rea05x2UlrQuERdwL+oJ3xUozYb+aKCqxEy
	 tw0bhq6PqMubrznElmbQDXcQ6cOMgj7cuAOmh7CC1VlzuY3H0iWxhi61s9UnODuoBdw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099801;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5deC3X/qxpVsXoeGtzPsqbNEXUMUJEJ5cVWR11tROm4=;
	b=R92FDwrDXGdQhWPrO+iAhMa/MSWU20ho1+0ysS1ikd2zxcXOyRKU8Q9eUEA4Nk5WT3Ju
	 aPS7+6/louxcBCw2UwXjDbQARppVq8ih4LSQrlBriHlWA87/8OKuGRXaWSGuCbyMjiEe+
	 zKFBtJ+kZ5mXFRbKp3yti1Mxgs0JwcR67D0TEyEIboxRWuFS8cm7FWTeYJROLmbavxFI0
	 ZDM49YQGtjw5gmxhzKvtb2UjYX+tYAXEuozGpNBkvpZPbF9aP6KkdbEQzj1b8nLlJ9EFg
	 Fe5tpFM53SjyUvsjDK7/iZjSEEYsNFOaRu+pGBXpuzkK0+zFwPhN1SVAjPSGRN591jQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OItje1WS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E49606A324
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 11:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29E49606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OItje1WS
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6acbdf8e70dso828911a12.1
        for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 04:16:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793099798; cv=none;
        d=google.com; s=arc-20260327;
        b=MA+de96qxWhvdvoVtxqr5yqjjQEy4u4LkerLrcV4dEh/5poRYI+dSbOm7B+o58c2Px
         /4gydR2FN9iXRvvxtIML/FTMUsXbvPMx+l9EMvMjEUqyaap6vRkoUViTjfxxyNvyl/XN
         WZe/QXt6/cs4ZbPGd6h2nZvrxWbzzN3QMFtSEXyJ8roHtNgBl4aj/d+m9bUfJia7h6QU
         w5rBZ48yfJsoQDllcbmtW1PV1TZC3/oeIK2BwfLYHvt5Cu3MuXNjlTMtzx8f1e9ib+Tm
         RpShxpRt6FJ3gE0SnuISZKmCLt5mQdfZI/MbQar+55h5onODYcBPCuMLasXzWuTD56PT
         gWaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5deC3X/qxpVsXoeGtzPsqbNEXUMUJEJ5cVWR11tROm4=;
        fh=Q1pnuqCs6jqKRTDQ2ydfVHunhGI5IOV6PFbpva0kEB0=;
        b=dkyd552pQ3rOuap6wSQqmWy5+iVarugi5lg02CGSNMOlVlh/NVAPipjuiVD67173y4
         Z8F8cZByplTpo6MZga+ttVeIosKSw3My9qthlELUlE2hftVC7720Csz9OkxS+9NxzWqb
         StWzYmKPGfV+BwePJBOQTR0l4M36t94rc0NgBqLmqC1fzbTCEmJHjNE1jVYrtrRi3GIQ
         5mKsdxkbZpx3GJhlPBAAWxbTRA74zaD/H/GXiviH02ybI+5wiSOU4E7X18X3tCVo7Td6
         4WuolsIWSNIZYY+bBt+uYYwFqTe2iwRJj+54oCXu+4OEHOqEM2tNgJFb+lJnuh5d1VHG
         C/xQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793099798; x=1793704598; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5deC3X/qxpVsXoeGtzPsqbNEXUMUJEJ5cVWR11tROm4=;
        b=OItje1WSFvSTAstbC+cKC8DxLKsH6FK00DsAH49fDoZJM4EO4zDF2cvDcuLWO+uzqS
         cwjlALT5y/XfGhvM4NumPBnnVtxNqkR274zklkWGeYtVGVPN4X0HGCVFnT1uEGvZRnK7
         nXvBVKdVT5peHBHwly80YwSc2w3NABFnUY8bZGMi2yFkaqhryZnZWRgqoM0rAmgcTW4G
         pPB5Peow/dCV1LKs0Gr8WiSaFfXJkB9ZXZirPTqoTFLn1wrkdx2lWaZq8u0i4zyWP8C6
         bjNEwN2uU/Eooo6t5vu7Fbts5LKooztoJbsyPQReD97VrA6+GO8rzx9/4/oX8l3nJXwk
         paPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793099798; x=1793704598;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5deC3X/qxpVsXoeGtzPsqbNEXUMUJEJ5cVWR11tROm4=;
        b=L5yAYB4UJ97/4yqP+Tzipd0nwtqmxALjCyLqYa3IGSxb/P+3YwrTNyqFTqM7mHDTzU
         yn7rcjKWm7C04gDDzvdEtgu3RneDbdvW4b8OQcKymsiYFEHcj14WD0rAClVo/q3x1owF
         PQ9QsNVmKZ8luY0Y3g09I8qJVwqAddmZ4ZG4w43gK7evIL1Szo8MEUnVot7fLPXDkWJU
         kyOfqwGulRml0tkguK5+EJPWGYgUlL3YtcUJkmPjTvkL2ZVirK8Tv3WwTjMWNMBCemYc
         VlLMIZeoezzBvvaSPS2OFR4Tpsc/Jy1wMHf5fygRYlMnCmd9+p4nNbuRFsQJmE2FkAyH
         Qt1A==
X-Forwarded-Encrypted: i=1; AKwUvByXnkRDSwDeqhEHx3NeeCN18RcT/mxPTkOW1Mu31rU6jFPG/fdQzj8ergHujdJc/jMsY6Id1uQNk72o@vger.kernel.org
X-Gm-Message-State: AFq9FYJwFKZxxvyWloP5v/GUEcFgRKgVjBiZbFL2QeI3h9O//mYQy2It
	qNDbumH4CXHcqJGRczUuNKDHWMbjpRGT6PC+oyCW98Gu0Z307qGWSITIDMsmxxJqz6vd+t8WoMK
	RlDdtnqURSK0BwBwZy0+/ZBj2XRKKzwI=
X-Gm-Gg: AYBFou1b2yG3wcDIDpSwIR4pq9YNgTt6iHH53J+HMoWLswPbxviT/wKe855pDcKopbL
	YPn9n3FWIW+WTSLrNlJB21Rdh7sdrhSsQomHFmEBiL6zE0a6q5TQsx3Eq45RBLiNkkVbHtII3ux
	5c/TQOPE0WmbiqDx/0v6a90Xwv/bfKZf67QYGBV3MtX2mf2A4U7XzrTG366cQZ7icik+OHRK4AU
	aV7bAfMBXHDrc/gQV1wsW5N08qSyvwY/GnFAW7ptgPgMY5jMLN74jJTEnCHG+bCgA5bO6JIthCD
	yUPOONx5z2hWTW3tdpZ7uSVQdeoVQPFUE6CliQwfJS1m790CKYc3FrMJn3ypQO5LEDkJO3QNaNM
	PX7Ct16nFMjqGXMv7FNVtGF7ecTXGmSQxiRhEpFBbrXRpHjWLjOnn1YpjCzjHNQhslcY4
X-Received: by 2002:a05:6402:a205:20b0:6b4:28d7:7b63 with SMTP id
 4fb4d7f45d1cf-6b4429fa178mr11365764a12.0.1793099798184; Tue, 27 Oct 2026
 04:16:38 -0700 (PDT)
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
In-Reply-To: <atisUaV2eIC2yTvX@linux.alibaba.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Tue, 27 Oct 2026 19:16:26 +0800
X-Gm-Features: AclHuK_A9PQEX0bWaCldRlg_sgr4SoZSYs9VVnOgllyUlJVTjvMgBfD6Uvd22n8
Message-ID: <CAAo+4rXas4BS85yfiDSPvDhzpWkjoKBiZSHn9VeV0VcATTO0Aw@mail.gmail.com>
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

Hi Dust,

Sorry for the late reply.

On Wed, Oct 21, 2026 at 8:13=E2=80=AFPM Dust Li <dust.li@linux.alibaba.com>=
 wrote:
>
> On 2026-10-13 17:17:15, Chengfeng Ye wrote:
> >smc_lgr_cleanup_early() enters __smc_lgr_terminate() even when another
> >teardown path has already claimed lgr->freeing. Both callers can observe
> >lgr->terminating clear before either sets it, then tear down the same
> >link group, causing use-after-free and duplicate resource release.
> >
> >  BUG: KASAN: use-after-free in __smc_lgr_terminate+0x393/0x3a0
> >  Write of size 1 at addr ffff8880bf2c0300 by task poc/106
> >  Call Trace:
> >   __smc_lgr_terminate+0x393/0x3a0
> >   __smc_connect+0x2e3d/0x4930
> >   smc_connect+0x42c/0x580
> >   __sys_connect+0xfc/0x130
> >   __x64_sys_connect+0x6d/0xb0
> >
> >Check freeing under the link group list lock before unlinking the group
> >or entering termination. The existing locked freeing transition then
> >claims exclusive teardown ownership; an early cleanup that loses the
> >claim leaves teardown to the existing owner and does not remove the grou=
p
> >from a device teardown's private list.
> >
> >Keep a temporary link group reference across smc_conn_free() and early
> >cleanup in smc_conn_abort(). Once the connection is unregistered, a
> >termination worker can finish without taking its socket lock. The extra
> >reference keeps the allocation alive until the ownership check returns.
> >
> >A new group is published before its first connection is registered. Hold
> >it before publication until registration or failed-registration cleanup
> >finishes. The reference keeps the allocation alive, but teardown can sti=
ll
> >destroy the group's resources before registration. Take the list lock
> >around the freeing check and first registration, nesting conns_lock as i=
n
> >the reuse path. Reject a group already claimed for teardown and clear
> >conn->lgr, since that connection never acquired a group reference.
> >
> >On success, acquire the connection reference before dropping the tempora=
ry
> >hold. A later terminator sees the registered connection and must acquire
> >its socket lock before removing it. On failure, keep the temporary hold
> >through early cleanup and then release it. Reused groups retain their
> >existing reference protocol.
> >
> >This depends on "net/smc: serialize link group free work scheduling" for
> >the standalone freeing bool and the locked early-cleanup transition.
> >
> >Fixes: f9aab6f2ce57 ("net/smc: immediate freeing in smc_lgr_cleanup_earl=
y()")
> >Cc: stable@vger.kernel.org
> >Assisted-by: GPT-6.1-Sol
> >Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> >---
> >Changes in v3:
> >- Serialize first registration with the teardown claim under the group l=
ist
> >  lock, nesting conns_lock in the same order as connection reuse.
> >- Reject groups already being freed and clear conn->lgr on that path.
> >- Document the scheduling fix prerequisite in the permanent commit messa=
ge.
> >
> >Changes in v2:
> >- Pin newly created link groups before publication, covering the
> >  registration failure handoff to early cleanup. Drop the temporary hold
> >  after cleanup on failure, or after the connection hold on success.
> >- Send after the free-work scheduling fix and reuse its standalone
> >  freeing bool and locked early-cleanup transition.
> >- Pin the link group across the smc_conn_abort() early-cleanup ownership
> >  check.
> >
> >v1: https://lore.kernel.org/r/20260927063607.3691520-1-nicoyip.dev@gmail=
.com/
> >
> >v2: https://lore.kernel.org/r/20261003183237.2284245-3-nicoyip.dev@gmail=
.com/
> >
> > net/smc/af_smc.c   |  8 ++++++--
> > net/smc/smc_core.c | 21 ++++++++++++++++++---
> > 2 files changed, 24 insertions(+), 5 deletions(-)
> >
> >diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> >index e9f93b3ab435..97b0a0b51066 100644
> >--- a/net/smc/af_smc.c
> >+++ b/net/smc/af_smc.c
> >@@ -1011,12 +1011,16 @@ static void smc_conn_abort(struct smc_sock *smc,=
 int local_first)
> >       struct smc_link_group *lgr =3D conn->lgr;
> >       bool lgr_valid =3D false;
> >
> >-      if (smc_conn_lgr_valid(conn))
> >+      if (local_first && smc_conn_lgr_valid(conn)) {
> >               lgr_valid =3D true;
> >+              smc_lgr_hold(lgr);
> >+      }
> >
> >       smc_conn_free(conn);
> >-      if (local_first && lgr_valid)
> >+      if (lgr_valid) {
> >               smc_lgr_cleanup_early(lgr);
> >+              smc_lgr_put(lgr);
> >+      }
> > }
> >
> > /* check if there is a rdma device available for this connection. */
> >diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> >index 660cd41ec720..c1bb284c4233 100644
> >--- a/net/smc/smc_core.c
> >+++ b/net/smc/smc_core.c
> >@@ -693,6 +693,10 @@ void smc_lgr_cleanup_early(struct smc_link_group *l=
gr)
> >
> >       smc_lgr_list_head(lgr, &lgr_lock);
> >       spin_lock_bh(lgr_lock);
> >+      if (lgr->freeing) {
> >+              spin_unlock_bh(lgr_lock);
> >+              return;
> >+      }
> >       /* do not use this link group for new connections */
> >       if (!list_empty(&lgr->list))
> >               list_del_init(&lgr->list);
> >@@ -999,6 +1003,7 @@ static int smc_lgr_create(struct smc_sock *smc, str=
uct smc_init_info *ini)
> >               lgr->buf_type =3D lgr->net->smc.sysctl_smcr_buf_type;
> >               atomic_inc(&lgr_cnt);
> >       }
> >+      smc_lgr_hold(lgr); /* lgr_put in smc_conn_create() */
> >       smc->conn.lgr =3D lgr;
> >       spin_lock_bh(lgr_lock);
> >       list_add_tail(&lgr->list, lgr_list);
> >@@ -2049,15 +2054,25 @@ int smc_conn_create(struct smc_sock *smc, struct=
 smc_init_info *ini)
> >               if (rc)
> >                       goto out;
> >               lgr =3D conn->lgr;
> >-              write_lock_bh(&lgr->conns_lock);
> >-              rc =3D smc_lgr_register_conn(conn, true);
> >-              write_unlock_bh(&lgr->conns_lock);
> >+              spin_lock_bh(lgr_lock);
> >+              if (lgr->freeing) {
> >+                      conn->lgr =3D NULL;
> >+                      rc =3D SMC_CLC_DECL_SYNCERR;
>
> This should not be SMC_CLC_DECL_SYNCERR, maybe SMC_CLC_DECL_INTERR or add
> a new error code.

No problem, I will use SMC_CLC_DECL_INTERR in v4.

> >+              } else {
> >+                      write_lock_bh(&lgr->conns_lock);
> >+                      rc =3D smc_lgr_register_conn(conn, true);
> >+                      write_unlock_bh(&lgr->conns_lock);
> >+              }
> >+              spin_unlock_bh(lgr_lock);
> >               if (rc) {
> >                       smc_lgr_cleanup_early(lgr);
> >+                      smc_lgr_put(lgr); /* lgr_hold in smc_lgr_create()=
 */
>
> smc_lgr_put() may call smcr_buf_free() -> vfree(), which may sleep.
> And you put it in the spinlock.

It seems the smc_lgr_put(lgr) is added after the
spin_unlock_bh(lgr_lock). Were you referring to another lock held by a
caller? I will keep this unchanged in v4, let me know if anything
should be adjusted further.

> Best regards,
> Dust
>

Best regards,
Chengfeng
