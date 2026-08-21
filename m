Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAA340F74A
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 06:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787294678; cv=none; b=FspG3jmiv3YL2Di4hLBR4JAhYe3+eaZHciWvHzFZzDzuzSkBIYx2rkRIJm0WQXmL/9TUWADL68OSTk/5pL7V1GInRaCM/37eYL8NYQ13/mTJIHiJSRI8h+O+JJSDTn/q8TduZoaN8aEuOW2+VMCwUPl+dBembRtNRZDrUTSR+tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787294678; c=relaxed/simple;
	bh=6M4mxpuM0hxTo4Ry5+mkcjkCvXkLB0/Ao6T5KDLDwwE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=klPPTBy7i3/LtGc1f2D1OZhnQfvtUwucqgpYG/ziI8uk91qmml+FZEyJznv4ikyOFXdAXEXIPb8ZjTP2vUGIeeXfjQCFG7SBxx0ft5Nk3PGIXxVbEwyNvWbZ0w4yofp1sRxjBg32PlGgVbemoxS2iIWbhGmQK2AC+Wbr3VN8sjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1v3WHfm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1v3WHfm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEEE41F000E9;
	Fri, 21 Aug 2026 06:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787294677;
	bh=ylYPB6++M44bj0T+yqkSNmaazJhsWv1SwAqO4ZRd/bU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z1v3WHfmlsgY1SFL624UgJLuWGZCZRHfSj0LDIsYww76/6VFtu/ulnJso61yUEz6Y
	 sA7xnn9bXCswcqRi01GfTdWx7WFHi0NBcZDC2lHGC+6tPWcTzwVvf0BYWhf0hUKMZ4
	 PsU8r/r/iL0V+NjinMRyelVPHDnKPrShPzdj/z39B7w9b0MUadpej5wcS7eq6bW3kV
	 6fWK8N9R2ikPoNdeiaMeociJbyomN39nH68ni45VMr3nJYPaLX102KbcAad+oJKHXJ
	 wbdT/kQk2DKG6DVneA51WrRLMSu/w/aLDsXASGE3GhvQVo9uIztFd0wR7vGPjqOvbz
	 s1IsJbbsOL/oA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5.10] net/smc: reject CHID-0 ACCEPT that matches an
 empty ism_dev slot
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrey Troshin" <drtrosh@yandex-team.ru>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260820064415.2061-1-drtrosh@yandex-team.ru>
References: <20260820064415.2061-1-drtrosh@yandex-team.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 06:44:36 +0000
Message-Id: <20260821064436.AEEE41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing bounds checks on offsets and array counts (e.g., `ism_=
gid_cnt`) in SMC CLC proposal message parsing allows out-of-bounds heap rea=
ds and unbounded array writes in `smc_check_ism_v2_match`, leading to heap =
buffer overflow.
- [High] Missing reference counting for ISM (`smcd_dev`) and RoCE (`smc_ib_=
device`) devices in `smc_init_info` across blocking network calls leads to =
Use-After-Free vulnerabilities.
--

--- Patch [1]: [PATCH 5.10] net/smc: reject CHID-0 ACCEPT that matches an e=
mpty ism_dev slot ---
commit 970c1e9eb76354e20020ef1c7e5ec94d92578af6
Author: Xiang Mei <xmei5@asu.edu>

net/smc: reject CHID-0 ACCEPT that matches an empty ism_dev slot

This commit fixes a null-pointer dereference in the SMC-D client. It preven=
ts
a malicious peer from matching an empty ism_dev slot by replying with a CHI=
D=20
of 0, which previously caused a crash when accessing the link group lock.

Link: https://patch.msgid.link/20260511062138.2839584-1-xmei5@asu.edu
Link: https://nvd.nist.gov/vuln/detail/CVE-2026-64048

> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 5dd4faaf7d6e5..72fa6d40916b8 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -831,7 +831,8 @@ smc_v2_determine_accepted_chid(struct smc_clc_msg_acc=
ept_confirm_v2 *aclc,
>  	int i;
> =20
>  	for (i =3D 0; i < ini->ism_offered_cnt + 1; i++) {
> -		if (ini->ism_chid[i] =3D=3D ntohs(aclc->chid)) {
> +		if (ini->ism_dev[i] &&
> +			ini->ism_chid[i] =3D=3D ntohs(aclc->chid)) {

[Severity: Critical]
This isn't a bug introduced by this patch, but is there an out-of-bounds re=
ad=20
and write when parsing SMC CLC proposal messages?

When reading the packet in net/smc/smc_clc.c:smc_clc_wait_msg():

    recvlen =3D datlen > SMC_CLC_RECV_BUF_LEN ? SMC_CLC_RECV_BUF_LEN : datl=
en;
    iov_iter_kvec(&msg.msg_iter, READ, &vec, 1, recvlen);

The data length is truncated to fit the fixed-size buffer. However, when=20
extracting the v2 extension in net/smc/smc_clc.h:smc_get_clc_v2_ext():

    return (struct smc_clc_v2_extension *)
           ((u8 *)prop_smcd +
           offsetof(struct smc_clc_msg_smcd, v2_ext_offset) +
           sizeof(prop_smcd->v2_ext_offset) +
           ntohs(prop_smcd->v2_ext_offset));

Does this calculate an out-of-bounds pointer because the unvalidated=20
v2_ext_offset is not checked against the truncated buffer boundary?

This appears to lead to an out-of-bounds read when checking array counts li=
ke=20
ism_gid_cnt in net/smc/smc_clc.c:smc_clc_msg_prop_valid().

Furthermore, in net/smc/af_smc.c:smc_find_ism_v2_device_serv(), the loop=20
iterates up to this unvalidated ism_gid_cnt:

    for (i =3D 1; i <=3D smc_v2_ext->hdr.ism_gid_cnt; i++) {
        smc_check_ism_v2_match(ini,
                               ntohs(smcd_v2_ext->gidchid[i - 1].chid),
                               ntohll(smcd_v2_ext->gidchid[i - 1].gid),
                               &matches);
    }

Inside net/smc/af_smc.c:smc_check_ism_v2_match():

    ini->ism_peer_gid[*matches] =3D proposed_gid;
    ini->ism_dev[*matches] =3D smcd;
    (*matches)++;

Can this overflow the fixed-size ini->ism_peer_gid and ini->ism_dev arrays=
=20
if the remote side controls ism_gid_cnt or repeatedly matches the same devi=
ce,=20
since *matches is not bounds-checked against SMC_MAX_ISM_DEVS?

[Severity: High]
This is a pre-existing issue, but does this code lack reference counting fo=
r=20
ISM devices across blocking network calls?

In net/smc/af_smc.c:smc_find_ism_v2_device_clnt(), raw device pointers are=
=20
collected in the ini struct without a reference count:

    ini->ism_dev[i] =3D smcd;
    ini->ism_chid[i] =3D chid;

The system then goes to sleep waiting for network data:
net/smc/af_smc.c:__smc_connect() -> smc_connect_clc()

When it resumes, the device pointer is dereferenced in=20
net/smc/smc_core.c:smc_conn_create():

    smcd =3D ini->ism_dev[ini->ism_selected];
    lgr_list =3D &smcd->lgr_list;
    lgr_lock =3D &smcd->lgr_lock;

If a hardware hotplug event unregisters the device while blocked in=20
smc_connect_clc(), could this lead to a use-after-free when smc_conn_create=
()=20
accesses the freed pointer?

>  			ini->ism_selected =3D i;
>  			return 0;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820064415.2061=
-1-drtrosh@yandex-team.ru?part=3D1
