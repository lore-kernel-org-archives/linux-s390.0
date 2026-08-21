Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A065943E9FC
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 11:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787310244; cv=none; b=Y7hrwDNCmslSaBkwsmrgeE4E7499X4Fd+G0ilUjKiRseM3XZxz+gnN9D5g8Z2Ek3NfusFcjwcqQtNDydx+R5Tm5Byoos4IJwKLrhQMU5k4dOvouBMXmkczcQjCuOBHOGnPaJG4DIfV+wCErzN8cZ6u+Fcvt8yS3YweAhwTRc/Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787310244; c=relaxed/simple;
	bh=L0Q3fG4q5Rr0AL7gU+KnPf4GVBW4NfLQkcd2Snd95/s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WawSxQljpH+DHtqnJm7JWx0DPYgGiVyWqTuAiCYpSL28S41xmHJr6QKJgFJT/V6U9VPqFAiVuSupQ78Vu0ahtDoUcW97B4ott8rSCPJrTbzAh2XE4Tf98sirgdjbUhdlJsj4OL9Sbmis/Bb2b4JdBrhAWMGfFcB3tzSyIaEu8YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSmuXlNd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSmuXlNd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3FEE1F00A3F;
	Fri, 21 Aug 2026 11:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787310242;
	bh=G46iQ1OCSZjkMNx88ev9CnDJPCx7SMfuEnPANe34sd8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HSmuXlNdSQVorMHCAtaQAnV2TqRaTzyzvrU+0OwYXUEIA+CYLj3FOK1ZzEmw5u1Um
	 OWVwJgP8RxEOfbqbV/PvCUfsz+6VozhlsMnyOhOE1lEJRoqShMLIa9HF9+kFYVXXAr
	 THm1buR0eOPE153zNzehvSGzQqJPyL+6/L7MmPPRSwnDryy1XaeWKwmQMTk1HLVdCa
	 8zaq7dpiAmoBo+P7A5d49SwzXFDo401hnYnQraqAOy7BXESL0zZTMVwjZca3SgxzZi
	 E6RZo4HB6xzptsQ6TKBENPRnbjQIolgip5WRtxPB3h3IeQnisNACV66UnQUHYA9EMe
	 a0cxSWjIVT1Pw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5.15] net/smc: reject CHID-0 ACCEPT that matches an
 empty ism_dev slot
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrey Troshin" <drtrosh@yandex-team.ru>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260820110310.2090-1-drtrosh@yandex-team.ru>
References: <20260820110310.2090-1-drtrosh@yandex-team.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 11:04:01 +0000
Message-Id: <20260821110401.F3FEE1F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unvalidated offsets and lengths in SMC CLC proposals allow arbitra=
ry out-of-bounds heap memory reads.
- [High] Use-after-free of `smcd_dev` and `smc_ib_device` across a sleep du=
e to missing reference tracking.
- [High] Unauthenticated NULL pointer dereference when processing SMC-D CLC=
 proposals with missing v2 extensions.
- [High] Remote heap buffer overflow in `ini->ism_dev` array during ISM dev=
ice matching.
--

--- Patch [1]: [PATCH 5.15] net/smc: reject CHID-0 ACCEPT that matches an e=
mpty ism_dev slot ---
commit 1aa51e986bc9d6f2f903ebb0f760865b75c754f4
Author: Xiang Mei <xmei5@asu.edu>

net/smc: reject CHID-0 ACCEPT that matches an empty ism_dev slot

On the SMC-D client, slot 0 of ini->ism_dev[]/ini->ism_chid[] is
reserved for an SMC-Dv1 device. smc_find_ism_v2_device_clnt()
populates V2 entries starting at index 1, so when no V1 device is
selected slot 0 is left in its kzalloc()'ed state.

Link: https://patch.msgid.link/20260511062138.2839584-1-xmei5@asu.edu
Link: https://nvd.nist.gov/vuln/detail/CVE-2026-64048

> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 78b663dbfa1f9..dd2a338eb6efe 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -869,7 +869,8 @@ smc_v2_determine_accepted_chid(struct smc_clc_msg_acc=
ept_confirm_v2 *aclc,
[ ... ]
> -		if (ini->ism_chid[i] =3D=3D ntohs(aclc->chid)) {
> +		if (ini->ism_dev[i] &&
> +			ini->ism_chid[i] =3D=3D ntohs(aclc->chid)) {
>  			ini->ism_selected =3D i;
>  			return 0;
>  		}

> net/smc/smc_clc.c:smc_clc_msg_prop_valid()
> (hdr->typev2 !=3D SMC_TYPE_N ?
> 	sizeof(*v2_ext) +
> 	v2_ext->hdr.eid_cnt * SMC_MAX_EID_LEN : 0) +

[Severity: High]
This isn't a bug introduced by this patch, but does this pointer calculation
validate that the offset is within the bounds of the allocated buffer?

It appears that in smc_get_clc_v2_ext(), the pointer is constructed using
an offset without bounds checking:

> net/smc/smc_clc.h:smc_get_clc_v2_ext()
> return (struct smc_clc_v2_extension *)
>        ((u8 *)prop_smcd +
>        offsetof(struct smc_clc_msg_smcd, v2_ext_offset) +
>        sizeof(prop_smcd->v2_ext_offset) +
>        ntohs(prop_smcd->v2_ext_offset));

Could this read beyond the heap allocation if the offset is too large?

[Severity: High]
This is a pre-existing issue, but if v2_ext_offset is explicitly 0,
smc_get_clc_v2_ext() returns NULL. Does this code safely handle a NULL
return for v2_ext? It looks like v2_ext->hdr.eid_cnt is unconditionally
dereferenced when hdr->typev2 indicates an SMC-D proposal.

> net/smc/af_smc.c:smc_find_ism_v2_device_clnt()
> ini->ism_dev[i] =3D smcd;

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for the device
to be unregistered and freed during a sleep in smc_clc_wait_msg()?

The device pointer is stored without taking a reference count to pin its
lifetime. Later, the potentially freed device pointer is dereferenced after
waking up:

> net/smc/smc_core.c:smc_conn_create()
> lgr_list =3D ini->is_smcd ? &ini->ism_dev[ini->ism_selected]->lgr_list :
>                           &smc_lgr_list.list;

Would acquiring a reference count prevent a dangling pointer here?

> net/smc/af_smc.c:smc_find_ism_v2_device_serv()
> for (i =3D 1; i <=3D smc_v2_ext->hdr.ism_gid_cnt; i++) {
> 	smc_check_ism_v2_match(ini,
> 			       ntohs(smcd_v2_ext->gidchid[i - 1].chid),
> 			       ntohll(smcd_v2_ext->gidchid[i - 1].gid),
> 			       &matches);
> }

[Severity: High]
This is a pre-existing issue, but is there a bounds check preventing matches
from exceeding the size of the ini->ism_dev array?

The loop executes based on ism_gid_cnt, and each unique match increments
matches and stores the device pointer:

> net/smc/af_smc.c:smc_check_ism_v2_match()
> ini->ism_peer_gid[*matches] =3D proposed_gid;
> ini->ism_dev[*matches] =3D smcd;
> (*matches)++;

Could this write past the end of the array if there are many ISM devices?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820110310.2090=
-1-drtrosh@yandex-team.ru?part=3D1
