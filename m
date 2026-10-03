Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com [74.125.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791B4471D0C
	for <linux-s390@vger.kernel.org>; Sat,  3 Oct 2026 19:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791056974; cv=pass; b=KzI4//w9EXdewEblOJUH9/rTj95MTTEh3kVXc1DUM3EMcNCAVT1SzFen2f5E8gyvB1wSjMblfGmqZDVIpjq/1M/FzHQUYjvp8JmQpn6Gbdru/dNA1Jf1uzhWfrL337P6kGNfcVVEq0wVzZYPtIal2t2QfVFzeHb9IV6HicNQYMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791056974; c=relaxed/simple;
	bh=c2qoWHsQlTh+5S32DI962bDO3NnnJ1VQFtDuQoujjfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H22pQ0uNZ2CyoGhHU4npsspxvIawbLBiY60/ImBvIS1zH+hPoBR5XheMXbAym7zuNTYvsMC4/6n/+ZlFW+nhgAqq2R87/J6MezOIajQeChmK0zN3OHSfQhAQPwbaybL0Z4kuHzZZG1+cMvH0mUzOFfxL1L0x2Dd7OnMO1X3182Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAS1QFOA; arc=pass smtp.client-ip=74.125.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAS1QFOA"
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6ad59dfd3a7so69369a12.0
        for <linux-s390@vger.kernel.org>; Sat, 03 Oct 2026 12:49:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791056970; cv=none;
        d=google.com; s=arc-20260327;
        b=di+/2L6wDEIsWy82qAAOcbIQKXyLf6qUh52m6PWaP0ff57wakTzFFKQG3Dmrfk4FCa
         rH7xKO5ULwqp2rSXh4pkRkMPJ3Q6J6sKnU8ndzDvxtMx+fChem9Qe4fAvCOKElC7DhKn
         SctxZsUmH1hkzlWB0dhusK1fGG0MYW8Rzp6mnp0XYoFNYu5C08O2JoZUXGV4Pyf+FUMo
         Lr5aYkTeSvWGjx3YXBldPlR3U31/o9LpEwhWW02lI3VJMGnajk9u+Wv3+fJpSD22v7sn
         DqEJiPEdIw39dGbk0lplsVQOePkAA9pzoHIw3/YvYREMwzY2bNGHYvwdI1hgZ8+xT13h
         B0pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bL60aTdrtyYKQsnQIlO0Kdzapjm5bDbHcbO8RKh/OCw=;
        fh=ZlxY9JxF9yJ3bHorzoSC4tZOXD3LVk8UbaT8Zy2T3Bo=;
        b=BCbpBdDo4oVVlxqsZXwTSU6hM/w8Dxr2qR/t+Esj/M3YvvPzPAUFQXzhdjCNWDsR1P
         Fpk1anohaNundVFrsLNNDT1dOVQICLRFwORaG/yEpVYIrftu1ZSZ/04O7j993tPNVUJs
         HIlwVszlyViu1L8D5NDqpIYB51Lf5H452/d6dueJEJ7JfGF1fM7pSLhC29niRsxqotAO
         ph8wGNxyNkqnXrhRaoAY+DgaA8RynyI7kGUnFKOx2NuY8eFlFP1WtpKIqI4dMnnVMNKk
         ksLmVgKSgIutOTf8C6T9fsaZaIwZePVekoDM2rgsTRifz8JiEEnzZkdkwTRx3ZfslvTx
         /XPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791056970; x=1791661770; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bL60aTdrtyYKQsnQIlO0Kdzapjm5bDbHcbO8RKh/OCw=;
        b=EAS1QFOA2+YyhspV4Nle7v47vYDOHFe7rgDdnmjugIevLnMwQBP5V5JN+mTRrH+Qve
         J62fquYVfK6cNWEK98FeEF+7kbfwGgAd5k9kIcnSIIXwgS4qXk6gkvxrjqTFhLzuKke0
         /tXNRpX50RchKwOARfTYnYUctG5LUPQzzPkKsT0FiERWiAbcmBeO6u8ovs9LXX0kfj2u
         z+lYoltLngXvi2dqs8IDsQLoXhXt5hBG2U0mJa8ecan1pJOyhRAFXl4idE5uLSgPDI+R
         e/hLBkFEymQbUjXY/4svpc9H0vDhXWK6JwyLfmOTHwDz3hNVPJ7P7FmQ7XBQYqe/sNAV
         fXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791056970; x=1791661770;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bL60aTdrtyYKQsnQIlO0Kdzapjm5bDbHcbO8RKh/OCw=;
        b=eyNKv9aa3GHhm7kabIoXAsIhK692SD1OUZKSddisIlJ+B4buXFy7pjlZyFWSnA7sII
         KJahS9vJxqtT0A5XDPXeWjoUT5YslSdASYNlRIeJN2hitPuT8ttZMKfQkztLgl+HGmW+
         JmgUOABcBcNhMuiHA3l3Hjw22XkaBNcVLmm07lVkCsBYK7O/8TY9sNjEbNfbL3z6kYWL
         dYGlOCmUfKHXpnmfZ7pw/yNioyYoKelKOrzNYkSe/nJtQYaSmtbGiQFWkZBd1VuniWbD
         X5PzyL1gilu0PEr+UCF+IweFxInkd/1fFIAK+iMSx5fxZio5ISaI0GQkkKOwK2R/22DW
         Qo0A==
X-Forwarded-Encrypted: i=1; AKwUvBx+JoTS0Gid/1VqaNg0CkFtmwMdUpDsYpGNAQm4uTAGG2uyDrRuVey4fizfAwXZFq4WLjEhcJXysvhY@vger.kernel.org
X-Gm-Message-State: AFq9FYJj2KyIf6cEpbfmr2sLB3ZetmawVtg65/xaX5KoIUqwKCea65Db
	MJu1OilDgVdk66CAdDhDtSYO1+27f02ymS+78ZKl9aPkDyqUShLn6OQrKo3O5h81hpV7IQTcKEJ
	6dPqoraMsPT+AQVQLtxNkAual6AYSHZE=
X-Gm-Gg: AYBFou37rDsL2HvS++RGJaSi1FNAL0vlezcHF9BwOhRqt5R2ioikiL0Hw/w+7HeMUwv
	TC6X9iPjxlveJktozKzhdNbuL79KxPpbSWAudmSZnX+h4XkXsv4KRSAcEhLpmZSeeJd09GlNnjF
	B4T0uV3PWd3j/HjRoCG7na8Cl7m0iSu+YD1Jk2F/TYVkVs4JlqHBnbds6t4LAMkOlZz2xONncGN
	EYsyxJ36+rOM+aU19ghLzyIWotbSIr5nssq7SrYjyDiwVyE9rOvxWp9/xGFkwVn7F35L1ccbeYK
	mjYOc9afc01UAz73nd1ftLt2o4viQA2dgS7CX5gr2Dndtk3S7YRB5UGtOHRKOVdccN4wbiUjQ0W
	yDqj7D+ynlDs=
X-Received: by 2002:a05:6402:1ed0:b0:6aa:a040:cc0b with SMTP id
 4fb4d7f45d1cf-6af9e26f8demr6054679a12.1.1791056969478; Sat, 03 Oct 2026
 12:49:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927074600.3694802-1-nicoyip.dev@gmail.com> <179072931609.434549.973981787075835588@kernel.org>
In-Reply-To: <179072931609.434549.973981787075835588@kernel.org>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Sun, 4 Oct 2026 03:49:18 +0800
X-Gm-Features: AclHuK_Y0i4trNbA9V55a6x6i4E4Q33ZR1G4G_SD7hO5cjoUUquUDzMxcOA1ENU
Message-ID: <CAAo+4rXocEj=0WZAtTD1em+c6SirU+4Bb-GEJ8P1piVnhxFCuw@mail.gmail.com>
Subject: Re: [PATCH net] net/smc: Serialize CLC preparation with link teardown
To: netdev-bot+sashiko@kernel.org
Cc: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, 
	sidraya@linux.ibm.com, mjambigi@linux.ibm.com, tonylu@linux.alibaba.com, 
	guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kgraul@linux.ibm.com, 
	ubraun@linux.ibm.com, linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 8:48=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 2 (2) =C2=B7 Low: 1 (1)
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] When smc_clc_send_confirm_accept() (net/smc/smc_clc.c) finds
>   that conn->lnk is unusable or being cleared under llc_conf_mutex, it=E2=
=80=A6
> - [Medium] smc_clc_send_confirm() (net/smc/smc_clc.c) now does
>   `smc->sk.sk_err =3D smc->clcsock->sk->sk_err ?: -len; reason_code =3D=
=E2=80=A6
> - [Low] The `sk_err ?: -len` changes in smc_clc_send_confirm() and
>   smc_clc_send_accept() (net/smc/smc_clc.c) do more than keep the new=E2=
=80=A6
>
> Pre-existing issues:
> - [Medium] This problem wasn't introduced by this patch, but it concerns
>   the locking contract the fix relies on.
> - [Medium] This problem wasn't introduced by this patch, but the patch
>   makes the CLC send helpers inconsistent.
> - [Low] This problem wasn't introduced by this patch (it dates from
>   2020).
>
> --
>
> net/smc: Serialize CLC preparation with link teardown
>
> This commit makes smc_clc_send_confirm_accept() hold llc_conf_mutex for
> reading while it prepares the SMC-R CONFIRM/ACCEPT message. If the link
> is unusable or being cleared, it returns -ENOLINK. It also changes
> smc_clc_send_confirm() and smc_clc_send_accept() to use the
> kernel_sendmsg() return value when the TCP socket has no sk_err set.
>
> > diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
> > index 014d527d5462d..6b9e64a5b9d0a 100644
> > --- a/net/smc/smc_clc.c
> > +++ b/net/smc/smc_clc.c
> > @@ -1169,14 +1169,21 @@ static int smc_clc_send_confirm_accept(struct s=
mc_sock *smc,
> >       clc->hdr.version =3D version;     /* SMC version */
> >       if (first_contact)
> >               clc->hdr.typev2 |=3D SMC_FIRST_CONTACT_MASK;
> > -     if (conn->lgr->is_smcd)
> > +     if (conn->lgr->is_smcd) {
> >               smcd_clc_prep_confirm_accept(conn, clc, first_contact,
> >                                            version, eid, ini, &fce_len,
> >                                            &fce_v2x, &trl);
> > -     else
> > +     } else {
> > +             down_read(&conn->lgr->llc_conf_mutex);
> > +             if (!smc_link_usable(conn->lnk) || conn->lnk->clearing) {
> > +                     up_read(&conn->lgr->llc_conf_mutex);
> > +                     return -ENOLINK;
>
> [Severity: Medium]
> Should this return a positive CLC decline code instead of -ENOLINK?
>
> Both handshake paths read a negative reason code as "fallback is not
> possible". On the client, smc_clc_send_confirm() returns -ENOLINK,
> smc_connect_rdma() jumps to connect_abort, and then
> smc_connect_decline_fallback() does:
>
> net/smc/af_smc.c:smc_connect_decline_fallback() {
>     ...
>         if (reason_code < 0) { /* error, fallback is not possible */
>     ...
> }
>
> As a result, connect() fails with ENOLINK.
>
> On the server, smc_listen_work()->smc_listen_decline() does:
>
>         if (reason_code < 0 ||
>             smc_switch_to_fallback(new_smc, reason_code)) {
>                 /* error, no fallback possible */
>                 smc_listen_out_err(new_smc);
>
> and the accepted connection is torn down.
>
> Other SMC-R link and buffer failures at the same stage return positive
> decline codes, send a DECLINE and fall back to TCP. Examples in
> smc_connect_rdma() are SMC_CLC_DECL_ERR_RDYLNK and
> SMC_CLC_DECL_ERR_REGBUF. Neither CONFIRM nor ACCEPT has been sent yet,
> so a DECLINE is still valid here.
>
> A matching code already exists and smcr_lgr_conn_assign_link() uses
> it:
>
> #define SMC_CLC_DECL_NOACTLINK  0x030a0000  /* no active smc-r link in lg=
r    */
>
> In multi-link groups, smc_switch_conns() skips SMC_INIT connections. A
> connection that is still handshaking therefore keeps the dying link
> even when another link is available.
>
> Could SMC_CLC_DECL_NOACTLINK be reported here so the connection falls
> back to TCP? The callers of smc_clc_send_confirm_accept() treat positive
> return values as byte counts, so the wrappers would need a small
> restructure to pass it through.
>
> The commit message also doesn't mention that this case now fails
> instead of falling back to TCP.
>
> > +             }
> >               smcr_clc_prep_confirm_accept(conn, clc, first_contact,
> >                                            version, eid, ini, &fce_len,
> >                                            &fce_v2x, &gle, &trl);
> > +             up_read(&conn->lgr->llc_conf_mutex);
> > +     }
>
> [Severity: Medium]
> This is a pre-existing issue, not one introduced by this patch, but it
> affects the locking contract this down_read() relies on.
> smcr_link_clear() is documented as:
>
> /* must be called under lgr->llc_conf_mutex lock */
>
> smcr_clnt_conf_first_link() in af_smc.c calls smc_llc_cli_add_link()
> without taking llc_conf_mutex:
>
>                 smc_llc_flow_qentry_clr(&link->lgr->llc_flow_lcl);
>                 smc_llc_cli_add_link(link, qentry);
>
> smc_llc_cli_add_link() calls smcr_link_init() and
> smcr_buf_map_lgr(lnk_new). On its out_clear_lnk error path it also
> calls smcr_link_clear(lnk_new).
>
> The other callers take the write side. smc_llc_process_cli_add_link()
> wraps the same function in down_write(), and smcr_serv_conf_first_link()
> and smc_llc_process_srv_add_link() do the same around
> smc_llc_srv_add_link().
>
> The new reader here doesn't seem able to see the cleared lnk_new. That
> slot isn't any connection's conn->lnk, and smc_client_lgr_pending
> serializes other client connections on this link group.
>
> Should smcr_clnt_conf_first_link() still hold llc_conf_mutex for
> writing around smc_llc_cli_add_link()? The new down_read() assumes
> that all link setup and teardown runs under the write side.
>
> >       memset(&msg, 0, sizeof(msg));
> >       i =3D 0;
> >       vec[i].iov_base =3D clc;
>
> [Severity: Low]
> This isn't a bug introduced by this patch (it dates from 2020), but
> further down, smc_clc_send_confirm_accept() builds up to five kvecs
> (header, fce_v2x, gle, gid list, trailer) and then sends them with num
> set to 1:
>
>         return kernel_sendmsg(smc->clcsock, &msg, vec, 1,
>                               ntohs(clc->hdr.length));
>
> kernel_sendmsg() passes num to iov_iter_kvec() as nr_segs. This only
> works because iterate_kvec() walks the segments by remaining length
> rather than by nr_segs. Afterwards, iter->nr_segs underflows:
>
>         iter->nr_segs -=3D p - iter->kvec;
>
> Should this pass i instead of 1?
>
> [ ... ]
>
> > @@ -1227,7 +1234,7 @@ int smc_clc_send_confirm(struct smc_sock *smc, bo=
ol clnt_first_contact,
> >                       reason_code =3D -ENETUNREACH;
> >                       smc->sk.sk_err =3D -reason_code;
> >               } else {
> > -                     smc->sk.sk_err =3D smc->clcsock->sk->sk_err;
> > +                     smc->sk.sk_err =3D smc->clcsock->sk->sk_err ?: -l=
en;
> >                       reason_code =3D -smc->sk.sk_err;
>
> [Severity: Medium]
> Can this copy -ERESTARTSYS into sk_err and into the connect() return
> value?
>
> On a blocking connect(), __smc_connect() runs in the caller's context,
> and the clcsock sndtimeo defaults to MAX_SCHEDULE_TIMEOUT. Suppose
> tcp_sendmsg_locked() waits in sk_stream_wait_memory(), for example
> under TCP memory pressure, while a signal is pending. It then returns
> sock_intr_errno(MAX_SCHEDULE_TIMEOUT), which is -ERESTARTSYS.
>
> With this change, smc->sk.sk_err is set to 512, which
> getsockopt(SO_ERROR) can expose. smc_connect() also returns
> -ERESTARTSYS, so the syscall may be restarted, for example after
> SIGSTOP/SIGCONT or with an SA_RESTART handler.
>
> smc_connect_decline_fallback() leaves sk_state at SMC_INIT and
> sock->state at SS_CONNECTING. On restart, kernel_connect() on the
> already connected clcsock returns -EISCONN. The application may read
> that as success, even though the SMC connection was aborted.
>
> The receive side in smc_clc_wait_msg() handles this case explicitly:
>
>         if (signal_pending(current)) {
>                 reason_code =3D -EINTR;
>                 clc_sk->sk_err =3D EINTR;
>                 smc->sk.sk_err =3D EINTR;
>
> Should the send side map signal errors to EINTR the same way? Before
> this patch the same case was reported as success, so the change helps,
> but the errno exposed here looks wrong.
>
> [Severity: Medium]
> This is a pre-existing issue, but after this change the CLC send
> helpers handle the same error differently. smc_clc_send_proposal()
> still does:
>
>         len =3D kernel_sendmsg(smc->clcsock, &msg, vec, i, plen);
>         if (len < 0) {
>                 smc->sk.sk_err =3D smc->clcsock->sk->sk_err;
>                 reason_code =3D -smc->sk.sk_err;
>
> sk_err can be 0 here: after sk_stream_error()->sock_error() clears it
> on EPIPE, or when the send fails with -EAGAIN, -EINTR or -ENOMEM. In
> that case this returns 0 even though the send failed. The client then
> waits in smc_clc_wait_msg() and is likely to hit an error or EOF there.
>
> Should smc_clc_send_proposal() use the same sk_err ?: -len fallback?
>
> >               }
> >       }
> > @@ -1246,7 +1253,8 @@ int smc_clc_send_accept(struct smc_sock *new_smc,=
 bool srv_first_contact,
> >       len =3D smc_clc_send_confirm_accept(new_smc, &aclc, srv_first_con=
tact,
> >                                         version, negotiated_eid, ini);
> >       if (len < ntohs(aclc.hdr.length))
> > -             len =3D len >=3D 0 ? -EPROTO : -new_smc->clcsock->sk->sk_=
err;
> > +             len =3D len >=3D 0 ? -EPROTO :
> > +                     -(new_smc->clcsock->sk->sk_err ?: -len);
> >
> >       return len > 0 ? 0 : len;
> >  }
>
> [Severity: Low]
> The commit message describes these two hunks as:
>
>     Preserve the preparation error in both CLC send wrappers when the TCP
>     socket has no error recorded. Otherwise the new -ENOLINK return is
>     converted to success.
>
> Is that the whole effect? The change also covers every failed
> kernel_sendmsg() where clcsock->sk->sk_err is 0.
>
> That case is common. When tcp_sendmsg_locked() fails with EPIPE,
> sk_stream_error() calls sock_error(), which clears sk_err. Timeouts and
> signals (-EAGAIN, -EINTR, -ERESTARTSYS) also leave sk_err at 0.
>
> Before this patch, those failures became reason_code 0 in
> smc_clc_send_confirm() and a return value of 0 in smc_clc_send_accept(),
> which callers treat as success.
>
> Could the commit message say that ordinary TCP send failures during
> CONFIRM/ACCEPT are no longer reported as success?
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260927074600.3694802-1-nicoyip.dev%40gmail.com

These pre-existing issues are variant of the data race reported by
this patch, now they are also addressed in v2
https://lore.kernel.org/netdev/20261003183325.2289707-1-nicoyip.dev@gmail.c=
om/T/#u.

Best regards,
Chengfeng
