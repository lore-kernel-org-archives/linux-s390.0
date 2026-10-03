Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D743AAF54
	for <linux-s390@vger.kernel.org>; Sat,  3 Oct 2026 19:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791056256; cv=pass; b=Mm4ZI4NuVwkepz/lhbTAyLr6jIea+8YXjIhn51IkG34jfBlVLzzUEVEk6cNTKxL8t4EnD/7lFbzJgF6QS09cKwjfd4Qa29SiqHxDrKDOHt3nEQeYbclr3UA0c+1PWBoXSSkiTfmfC4s4Ic8xNnZsfy8H9jpGrPOESq02EoqFBTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791056256; c=relaxed/simple;
	bh=RQdISwCIeTHJRNNRYXKnQccif86ZtXCpqBErB1KRL7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZHgKy7Bl/4KLbtiKFtw8cEYIT+c46R4SV82En8vgr361LBl2GQvmAG348iZPCucM8fJT8P0Pqo1slifAgI32fAfAtcU5OSJ0UuFFzRCD2r13lz+5YA0l4m9+4RiHVETFqfzciI82kE7MQAoJy9TLt0ZG1eqbcKJY8SiNLC/Y1B8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p2qBkOJb; arc=pass smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p2qBkOJb"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2a837b0c2bso11414266b.3
        for <linux-s390@vger.kernel.org>; Sat, 03 Oct 2026 12:37:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791056252; cv=none;
        d=google.com; s=arc-20260327;
        b=NTUAu92ilEl7BpxVOhFMkzHfyoCzeckJpKvA8SyprbRCOwZCbMJyYk5cQXkEUmF8LB
         UQhE1RyWkDkkNulD2KHsReWoRki8sU9ShPcX8NgPHqKc2I/D8/uMNHBPoHnUPXTVj4Nz
         frVZSxcm8mCLffx66HNsaQ0V5gOt9kpYuN7EGcRqnELrYfY5V2NTeLfc2kdDni7LaTf2
         yzvP1szdPG78ie5gvGwDP5EnXXlFHY1fH3+GiLAOIiWWg7l2S5djx6rP7Fgdsrm0UJxz
         H8EwZubsZmVKLaUQ08ajWv6BaZ1kudByMiiR8bLWJ7Y3dKz4GXryDQ4HtYYxGu2cSkki
         UBjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+1sgNjTuEhjk9Api27Ek7GbjZW7LaWBth9pDAUxc4Wk=;
        fh=Qy8XfNhkrTPToDgY4PibIy9h4t6osma9o25/6Mj93xE=;
        b=RGECHHLVSaw+iIolCKx/ANNS+mebxlRFfpk9szobIroEinSxI9uza8Uf3PMNxnk4YA
         Y2jBqMV/KCwdN2DNmS2GTJXiyaUF2gKddblir6WJw0C4rE68EpIJH1M1EF3Z1FsR8XXM
         w2PyNJk30K3LtYO0lvZw1RcWjAdIKVnvDREiK7eeBabVeHVVKb3JtzB0RUsxmWEY2me7
         VoYYvuyTsqSZIcQVdVQwKcmhqVONLyZ1b/pCUJlaANufz0xqN2cYDfWicIYb5laNcRlh
         G7qz9wR7ilboUH7kAl+c/UspD1e3lWCJhZK1fLGKhTJ5qkmZ/ZfdMMo35hQgsCJK5PXc
         Q4nQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791056252; x=1791661052; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+1sgNjTuEhjk9Api27Ek7GbjZW7LaWBth9pDAUxc4Wk=;
        b=p2qBkOJbe0JoIVZCajmcrQTxkDnY+IOH3/Tk7u4MNIVFwtr+MwYQD/b8Wiq+6L1Z5D
         XH8mXaO7g+fmFom3HdXa+rO/y6TynLCKTZZpNl6SscUG+2P0WMrwx5aRc3kjGm6PfhRd
         1Rr8zmBaUPRzZe1ZoIUjLsdfPRDUU8P5zuF9k9YDE+0VfkHUzJduxWdNTQ6ThddUKhmO
         2M7odiGaEisdf693nRTuGLEe1H63qaLVrTKKCXqkbNhho+sqeZzA8Euk8bvc1Bq1rnMp
         omDjAxvICJx04pmTcLSMIRTpsmpop8GR/dN9vInYBmrSD2ufRbKFagmEqiFPTI5+Rh+f
         Ylcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791056252; x=1791661052;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+1sgNjTuEhjk9Api27Ek7GbjZW7LaWBth9pDAUxc4Wk=;
        b=QSh3efcWneiWlssO7OT5U0A62gZH1LBrpSU3usI43ePkslcFVP3JziI7eu9e+Whdls
         82Ou7FM5nuC52mkXEPgD1EFkImJH4KIjVQqUo6WAk06nBMBMMWxX8hzkzl3i+setHsNk
         tB9zrN4xhhN96Z5sS6fhq6LnIayFH7wO+6mhQrJRlte9riffqC2X5o5in5NfnQF33HH4
         xuy5i9gaOAA7Mkh0mdJBY6jlxRK279wL1+wZzISCXI8B7ThfEggug9bV5OzaA2cSDBBf
         tIcm/bZIMU5Hr1HGR7GmeuTI/wNP1j3NGMuu43OJdNSP+LBxPebSeMPWEjJ5si2H9U2k
         dG9Q==
X-Forwarded-Encrypted: i=1; AKwUvBwLCirGTkCzQfY4Qo5UD47elM5ug7ogjXRe4yODe5LxB8RJw/cloKs/+F86R4phGz8hFGxXJkyHGh6F@vger.kernel.org
X-Gm-Message-State: AFq9FYJuzEwwrGqButz4e38oeHWs+nBRckVKhCAtLsXKKRwN+icjDmzp
	LGfet3AvQAcRI5afPPuDeeMogb921X7R+fRWUbzoN5gn0+nR3DFU+iZ/xv5DqGG1xrRDYiYE6au
	OO+eyb9uPianMAJ3jC55xHBkrpRpEYTY=
X-Gm-Gg: AYBFou2xitx+Ae+eIv47bUQasWcOZHohxG433GMvtyBt+gNejEv1dtDuj9PUhnWi0b7
	nmTFzoeOrzbA+ayLNMOTVDlSv4hYrIWEaW4nC8eEoQYOisC9WbokH+Pj1x7Dco7aGeDOpj5kV4b
	iCZwuWt6HIQu59xEug5pfTdMRsCZuYqcfHCvP4F+7Kcat6eTtmCDRMPMhdMr+Booxz1tmpk0zGI
	dFlkyBqw7iRHr0+xMxYkOw5iIPiZ+ooVb6vOGBS63L393c9UztlY7CEux4FaZ8cTEZ0Oc0uVQ3z
	myvGNz+mN/JZCUsIdfGVPM6T4gZWUC6YfzrMXFWspbMUSHMt+huBSaCf1Ufpuei4VAwawHRQwhS
	M7CpV1Yc4RYDrywEPMhYKpA==
X-Received: by 2002:a05:6402:1ed0:b0:6aa:a040:cc0b with SMTP id
 4fb4d7f45d1cf-6af9e26f8demr6033264a12.1.1791056251842; Sat, 03 Oct 2026
 12:37:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927063607.3691520-1-nicoyip.dev@gmail.com> <179072873236.434549.5842458403458661428@kernel.org>
In-Reply-To: <179072873236.434549.5842458403458661428@kernel.org>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Sun, 4 Oct 2026 03:37:18 +0800
X-Gm-Features: AclHuK9p6aQ_J43EOVKpodci3vxNOzsM7jVie2jHyLl0wZCCleShlxslsIU4Ncg
Message-ID: <CAAo+4rVATDapayqSFFjRaNxFod=bnUGk66opVVUgdwVBr48FNg@mail.gmail.com>
Subject: Re: [PATCH net] net/smc: Serialize early link group cleanup with termination
To: netdev-bot+sashiko@kernel.org
Cc: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, 
	sidraya@linux.ibm.com, mjambigi@linux.ibm.com, tonylu@linux.alibaba.com, 
	guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ubraun@linux.ibm.com, 
	kgraul@linux.ibm.com, linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 8:38=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 1 =C2=B7 Low: 0 (1)
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] The patch covers only one of the two callers of
>   smc_lgr_cleanup_early().
> - [Medium] Early cleanup can free the link group while a
>   smc_lgr_free_work() callback that has already started is still using=E2=
=80=A6
>
> Pre-existing issues:
> - [Low] In __smc_lgr_terminate() (net/smc/smc_core.c:1573-1574), the
>   comment says "cancel free_work sync, will terminate when lgr->freeing=
=E2=80=A6
>
> --
>
> net/smc: Serialize early link group cleanup with termination
>
> This commit makes smc_lgr_cleanup_early() check and claim lgr->freeing
> under lgr_lock before it calls __smc_lgr_terminate(). This stops early
> cleanup from racing with the other teardown paths. It also makes
> smc_conn_abort() hold a temporary link group reference across
> smc_conn_free() and early cleanup.
>
> > diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> > index e9f93b3ab435b..97b0a0b510664 100644
> > --- a/net/smc/af_smc.c
> > +++ b/net/smc/af_smc.c
> > @@ -1011,12 +1011,16 @@ static void smc_conn_abort(struct smc_sock *smc=
, int local_first)
> >       struct smc_link_group *lgr =3D conn->lgr;
> >       bool lgr_valid =3D false;
> >
> > -     if (smc_conn_lgr_valid(conn))
> > +     if (local_first && smc_conn_lgr_valid(conn)) {
> >               lgr_valid =3D true;
> > +             smc_lgr_hold(lgr);
> > +     }
>
> [Severity: High]
> This adds a reference for the smc_conn_abort() caller, because the new
> lgr->freeing check needs the link group to still be allocated. Does the
> other caller of smc_lgr_cleanup_early() need the same protection?
>
> net/smc/smc_core.c:smc_conn_create() {
>     ...
>                 write_lock_bh(&lgr->conns_lock);
>                 rc =3D smc_lgr_register_conn(conn, true);
>                 write_unlock_bh(&lgr->conns_lock);
>                 if (rc) {
>                         smc_lgr_cleanup_early(lgr);
>                         goto out;
>                 }
>         }
>         smc_lgr_hold(conn->lgr); /* lgr_put in smc_conn_free() */
>     ...
> }
>
> The hold is only taken after registration succeeds. On the failure path,
> smc_lgr_cleanup_early() runs without a reference of its own.
>
> For SMC-R first contact, smc_lgr_register_conn() fails through
> smcr_lgr_conn_assign_link() only when the new link is no longer
> SMC_LNK_ACTIVATING. As far as I can tell, that happens only when
> __smcr_link_clear() resets the link inside a teardown's smc_lgr_free(). T=
hat
> teardown drops the link's lgr reference and then the initial one. For
> example:
>
> smc_smcr_terminate_all(NULL)   /* reboot notifier via smc_lgrs_shutdown()=
 */
>     list_splice_init(&smc_lgr_list.list, &lgr_free_list);
>     lgr->freeing =3D 1;
>     __smc_lgr_terminate(lgr, false)
>         smc_lgr_free()
>             smcr_link_clear()->__smcr_link_clear()  /* link UNUSED, lgr p=
ut */
>             smc_lgr_put(lgr); /* theoretically last lgr_put */
>                 __smc_lgr_free()->kfree(lgr)
>
> The connecting thread (connect() or the smc_hs_wq listen worker) then see=
s
> registration fail and calls smc_lgr_cleanup_early() on the freed lgr. The=
re,
> smc_lgr_list_head() reads lgr->is_smcd and the new check reads
> lgr->freeing.
>
> The commit message says:
>
>     The extra reference keeps the group alive until early cleanup has
>     checked teardown ownership.
>
> The smc_conn_create() caller has the same lifetime requirement. Is a
> use-after-free from early cleanup racing with termination still reachable
> through that path? The window is narrow. It looks like it needs a teardow=
n
> such as a reboot to run during an SMC-R first-contact handshake.
>
> >
> >       smc_conn_free(conn);
> > -     if (local_first && lgr_valid)
> > +     if (lgr_valid) {
> >               smc_lgr_cleanup_early(lgr);
> > +             smc_lgr_put(lgr);
> > +     }
> >  }
> >
> >  /* check if there is a rdma device available for this connection. */
> > diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> > index 9974149659c2f..b166a379753c7 100644
> > --- a/net/smc/smc_core.c
> > +++ b/net/smc/smc_core.c
> > @@ -688,6 +688,11 @@ void smc_lgr_cleanup_early(struct smc_link_group *=
lgr)
> >
> >       smc_lgr_list_head(lgr, &lgr_lock);
> >       spin_lock_bh(lgr_lock);
> > +     if (lgr->freeing) {
> > +             spin_unlock_bh(lgr_lock);
> > +             return;
> > +     }
> > +     lgr->freeing =3D 1;
>
> [Severity: Medium]
> Can early cleanup free the link group while a smc_lgr_free_work() callbac=
k
> that has already started is still using it?
>
> After freeing is claimed here, __smc_lgr_terminate() only does a
> non-synchronous cancel:
>
> net/smc/smc_core.c:__smc_lgr_terminate() {
>     ...
>         /* cancel free_work sync, will terminate when lgr->freeing is set=
 */
>         cancel_delayed_work(&lgr->free_work);
>         lgr->terminating =3D 1;
>     ...
> }
>
> free_work is queued on system_percpu_wq, not lgr->tx_wq. So
> destroy_workqueue(lgr->tx_wq) in smc_lgr_free() does not flush it. The
> callback also holds no lgr reference.
>
> Suppose the callback has started but has not yet reached the freeing chec=
k:
>
> net/smc/smc_core.c:smc_lgr_free_work() {
>     ...
>         smc_lgr_list_head(lgr, &lgr_lock);
>         spin_lock_bh(lgr_lock);
>         if (lgr->freeing) {
>     ...
> }
>
> Teardown can then run to completion. smc_lgr_free() drops the initial
> reference, and the new smc_lgr_put() in smc_conn_abort() drops the last
> one. __smc_lgr_free() then frees the lgr and its embedded free_work, and
> the callback goes on to dereference freed memory.
>
> The commit message says:
>
>     This also prevents early cleanup from racing with the delayed free
>     worker
>
> It looks like the freeing flag only prevents a second teardown while the
> object is still allocated. It does not keep the lgr alive for a worker th=
at
> lost the race. Is the commit message accurate here?
>
> To trigger this, the SMC_LGR_FREE_DELAY_* timer has to expire during the
> creator's abort. That looks like it needs an unusual stall or a jiffies
> jump.
>
> [Severity: Low]
> This isn't a bug introduced by this patch, but the comment in
> __smc_lgr_terminate() quoted above says "cancel free_work sync". The code
> calls cancel_delayed_work(), which does not wait for a callback that is
> already running.
>
> What protects a pending smc_lgr_free_work() is its own re-check of
> lgr->freeing under lgr_lock, not a synchronous cancel. Early cleanup now
> reaches this code after claiming freeing. Could the comment be updated to
> match the code?
>
> >       /* do not use this link group for new connections */
> >       if (!list_empty(&lgr->list))
> >               list_del_init(&lgr->list);
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260927063607.3691520-1-nicoyip.dev%40gmail.com

The issues (incomplete fix and comment consistency) identified are
addressed in v2
https://lore.kernel.org/netdev/179105277608.1402591.16173087244761956438@ke=
rnel.org/T/#t

Best regards,
Chengfeng
