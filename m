Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266A7470E82
	for <linux-s390@vger.kernel.org>; Wed,  5 Aug 2026 12:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785933308; cv=none; b=sqJKRAgUU5N6qlGhG/F4Wd3XYTDZkIfsEBI1COwW9oafD1Ub1tk81Sd02+idR4w7MassslZHpDV74z4SvccpSUywxvW7mROAMxJG3OGqH5z2x4wjs48q6q0b1rHJ8BpUCBYGupHPFOiUSj29gvTx4HFwvRXdQMP9k/823Dg9P6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785933308; c=relaxed/simple;
	bh=O0zFK5x8J6afBNHCJqaAgfmKoSwIcqTlpvvijgW1eSA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k4OQa2K6bz/DYZMybUP+qAtXyqVYhYQoo+zZu+TsP83UZ8xYcXE/tZfCizlCdagUzz2Uv/Tei6CsJXUmElYDhbk9QD0Qfr4iVdB2Jruwpp/RuKTaKZafB8Zbdy0FjVBTPI92AUquLm/240I/arg4zUEAODoM/qyP1ZWTSIt3txU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deW4wDnv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deW4wDnv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4CC1F00A3A;
	Wed,  5 Aug 2026 12:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785933306;
	bh=CMS2BelvngQSs1BgvAHXw8Q8pxZpETKNGCab0olQoXA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=deW4wDnv1+8p9IaEucJ3l2CyIlau12l9WZ6sc/fQZniTiSLMqEv9s+t8Zo/ypHfuA
	 61NXAsKYu7sTD3qLYIn5Z4dlrkbbU7GYVCduIqFcIt8L0iaDtjfewjcf+Z05k3zcut
	 wGDpC1EHfjD6B0lreQGITjEF3xg6kM3QHFDYI5Cpxc4w8UdQ0t0YA59hJxYL/guOHk
	 lv161FmGxNJ0seKh+IdmNh9QrD3LiVRUD8tNDaTdN+NVEd7cv+bFySb7NaBnQ5VvAH
	 TT2RL/jwUESnvTGnb9i8CWvo88AnXSHdjLGjjR9dKIy7dUTnbUQ1GbfFzn+EDm+/lQ
	 lec2Dfwnp+4zA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net/smc: prevent device removal during connection
 setup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qi Zhang" <marsy12010123@gmail.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260804123418.2214979-1-marsy12010123@gmail.com>
References: <20260804123418.2214979-1-marsy12010123@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 12:35:05 +0000
Message-Id: <20260805123506.4A4CC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Use-After-Free in smc_ibdev_init_put() racing with smc_ib_remove_d=
ev()

Pre-existing issues:
- [High] Incomplete Fix / Use-After-Free for SMC-D (ISM) devices during con=
nection setup
--

--- Patch [1]: [PATCH net] net/smc: prevent device removal during connectio=
n setup ---
commit 7f17c01034c751116f18a345f6abf2f1dee4b013
Author: Chengfeng Ye <nicoyip.dev@gmail.com>
Subject: net/smc: prevent device removal during connection setup

This patch introduces a reference count mechanism to track in-flight
connection setups and prevent SMC-R devices from being removed prematurely.

> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index b5db69073e20f..160271464305c 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
[ ... ]
> @@ -1596,14 +1596,14 @@ static int __smc_connect(struct smc_sock *smc)
>  	SMC_STAT_CLNT_SUCC_INC(sock_net(smc->clcsock->sk), aclc);
>  	smc_connect_ism_vlan_cleanup(ini);
>  	kfree(buf);
> -	kfree(ini);
> +	smc_init_info_free(ini);

[Severity: High]
This is a pre-existing issue, but while this patch addresses the use-after-=
free
for RoCE devices, does the same vulnerability still exist for SMC-D (ISM)
devices?

Looking at the connection setup path, an ISM device pointer is selected and
stored without taking a reference:

net/smc/af_smc.c:smc_find_ism_v2_device_clnt() {
    ...
    ini->ism_dev[i] =3D smcd;
    ...
}

If the ISM device is unregistered concurrently, smcd_unregister_dev() frees=
 it
without waiting for in-flight connection setups:

net/smc/smc_ism.c:smcd_unregister_dev() {
    ...
    kfree(smcd);
}

When the connection setup resumes, the freed smcd pointer is dereferenced:

net/smc/smc_core.c:smc_conn_create() {
    ...
    lgr_list =3D ini->is_smcd ? &ini->ism_dev[ini->ism_selected]->lgr_list :
                              &smc_lgr_list.list;
    ...
}

Should a similar initialization reference count be added for SMC-D devices?

> diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
> index 9bb495707445e..01c9b5c62df76 100644
> --- a/net/smc/smc_ib.c
> +++ b/net/smc/smc_ib.c
[ ... ]
> @@ -1000,6 +1002,9 @@ static void smc_ib_remove_dev(struct ib_device *ibd=
ev, void *client_data)
>  	mutex_unlock(&smc_ib_devices.mutex);
>  	pr_warn_ratelimited("smc: removing ib device %s\n",
>  			    smcibdev->ibdev->name);
> +	if (atomic_read(&smcibdev->init_cnt))
> +		wait_event(smcibdev->init_wait,
> +			   !atomic_read(&smcibdev->init_cnt));
>  	smc_smcr_terminate_all(smcibdev);
>  	smc_ib_cleanup_per_ibdev(smcibdev);
>  	ib_unregister_event_handler(&smcibdev->event_handler);
> diff --git a/net/smc/smc_ib.h b/net/smc/smc_ib.h
> index ef8ac2b7546df..8e9fd5a200a2b 100644
> --- a/net/smc/smc_ib.h
> +++ b/net/smc/smc_ib.h
[ ... ]
> @@ -59,6 +61,17 @@ struct smc_ib_device {				/* ib-device infos for smc */
>  	int			ndev_ifidx[SMC_MAX_PORTS]; /* ndev if indexes */
>  };
> =20
> +static inline void smc_ibdev_init_get(struct smc_ib_device *smcibdev)
> +{
> +	atomic_inc(&smcibdev->init_cnt);
> +}
> +
> +static inline void smc_ibdev_init_put(struct smc_ib_device *smcibdev)
> +{
> +	if (atomic_dec_and_test(&smcibdev->init_cnt))
> +		wake_up(&smcibdev->init_wait);
> +}
> +

[Severity: High]
Can this race with device removal and cause a use-after-free of smcibdev?

If Thread A executes smc_ibdev_init_put() and drops the count to 0 via
atomic_dec_and_test(), it might be preempted before calling wake_up():

Thread A:
    if (atomic_dec_and_test(&smcibdev->init_cnt))
        <preempted>

Thread B then executes smc_ib_remove_dev(), sees the count is 0, skips
wait_event(), and frees the device:

Thread B (smc_ib_remove_dev):
    if (atomic_read(&smcibdev->init_cnt))
        wait_event(...) // skipped
    ...
    kfree(smcibdev);

When Thread A resumes, it will call wake_up() on the now freed smcibdev
pointer.

Could this be avoided by using standard completions or by moving the cleanup
logic into a release function when the count reaches zero?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804123418.2214=
979-1-marsy12010123@gmail.com?part=3D1
