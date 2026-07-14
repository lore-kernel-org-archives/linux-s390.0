Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5153F8222;
	Tue, 14 Jul 2026 08:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784017949; cv=none; b=Pc7Wh3VwRm6Sl5nDtlxMKqfRQ4lRFifObM0oOGUkw26FiAosod2NUaTJSjoQYhhCGinamsaNQ9U2tuU2VPTUOUsx0IM5nWVZtEVs8x3N+ZOB/sZQ4rfJAiz3Uq/76sG7FkBD7lb9DXz+531T0y8dFsZXXJd71g8IQRP3vMXt2nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784017949; c=relaxed/simple;
	bh=ZTWSTQzVtfcxnsekBcTrSfK73D+KDzsaOxPlJ2s/1eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wt09Lola2lZycd84fg5XNAzBD4zRLIo/fXrViQsOpEjS4dtMhcbcSJ9R8ZIXlrwmCoMK75WDFWmBJCuWJJh91y52tduPcrPUM6UZL8Wg8J4mJ6jo8xJrA9anghok6fC25wsI7tS8SejmjaOGF8JizxEZPNar0m/X8af7CcracIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mo1WrqVJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mo1WrqVJ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E6frQR559218;
	Tue, 14 Jul 2026 08:32:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=h+EcWsrei9bp0xr/6b/fJChOtPGXya
	aEz8btC6MODn0=; b=mo1WrqVJvoBcAfOq3Vcn/MlMzbqE4kWxL8Q3gs+GHYcC86
	vmd2f3AUdVKI8Z3loTN8CqW5L27qON0VP8v574mCTuPYT2Bp9rM2Fxd2FcwxfXVb
	wrLui0lBkA4WHxfAD/IiGij9A/PL3yUZ08CgJj2EmqY+FepuOzJHeUKylIaNv2ck
	Ro5CqDP5n9vfi4OWxXYqv2vpLFFLf1LZPrJ0NckgH8SryBCAgqqkulA+LWWGYD+t
	wb0FcNE+ngIsFaaB/UKmCvulQubF8mUNl3yQQzqtRyCKvF22U0Vgl7AmDDwOe9Fo
	FdRmreE5b5pIseUeZn0GKuLlziJu+muxYA1Mg2ew==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbepxd1c0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 08:32:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66E8JxjU003970;
	Tue, 14 Jul 2026 08:32:18 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cg9jcb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 08:32:18 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66E8WEJs15728914
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 08:32:14 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8731420043;
	Tue, 14 Jul 2026 08:32:14 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C15920040;
	Tue, 14 Jul 2026 08:32:14 +0000 (GMT)
Received: from osiris (unknown [9.224.76.185])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 14 Jul 2026 08:32:14 +0000 (GMT)
Date: Tue, 14 Jul 2026 10:32:13 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, nrb@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: Re: [PATCH v2 1/7] KVM: s390: Fix unlikely NULL gmap dereference
Message-ID: <20260714083213.55132-H-seiden@linux.ibm.com>
References: <20260713150857.269954-1-imbrenda@linux.ibm.com>
 <20260713150857.269954-2-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713150857.269954-2-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IBWQrq7AX4lu_-INYHaCM3s4EIIx5OyT
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA4NSBTYWx0ZWRfX9vKDzp/Mu/1d
 3x5BQWBxn/xPGcVU9dei1wpgmStBtKk+RSro1aXXhwka5m3JlgLJu24W2vveAMqMI3usv79WqEG
 9DO/JHOgWfc51ShlH5fmyjIzQSTekXA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA4NSBTYWx0ZWRfX+Jrz1NAJfbBz
 dsPkRANbkutQ6G/0PmlhbUfMlcc7EqfM+FbqjRnfMsOyPQDKkUfT/j6hS+v8/80H0b+dnoCSoEk
 RYNQdt78AE6aF/wOMjhG3pu15gcD4BbDV9sV++TNSMm9TgVhr3WpB1yVcPmJiTWbtCpSdV/1wd4
 3PAelrO6ziozoXD7nQbrbb8zBf8ajV8XQBND4vPLJS3nPSyMpencFFf/l9PbDA0NHjMgczjeUqo
 NCmJlTBZ6yJdqCKQCP9+8W9J4fiHWNcn5m/BEYTUpUKRIQNzAf+8LLdh/VNr/dxJmRcl4FXNh6v
 wqN1mdkB3otC4/d/FGiRWkHiVGK27RwPTiqrLfsKkl9nW+nKR9mKHk27njv6Wj5ebd2oXiCsdoK
 bNmNaIIX1V7UXuCSWlEX+2ZDUBQoGQoyWaEXSQcfKlmynSU1yLkdZizXM31aglom+AlYDi2CJMs
 GFAOokhNlq0qwWpCSTw==
X-Authority-Analysis: v=2.4 cv=XbS5Co55 c=1 sm=1 tr=0 ts=6a55f413 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=xEKy2pP93_wNeioO2_kA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: IBWQrq7AX4lu_-INYHaCM3s4EIIx5OyT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140085

On Mon, Jul 13, 2026 at 05:08:51PM +0200, Claudio Imbrenda wrote:
> When creating a new vCPU, kvm_vm_ioctl_create_vcpu() will call
> kvm_arch_vcpu_postcreate() after the file descriptor for the new vCPU
> has been created. The new file descriptor has not been returned yet,
> but a malicious userspace program could try to guess it.
> 
> If a malicious userspace program manages to start the newly created vCPU
> before kvm_arch_vcpu_postcreate() is called, __vcpu_run() will try to
> dereference vcpu->arch.gmap and trigger a NULL pointer dereference.
> 
> Fix this by moving the initialization of vcpu->arch.gmap into
> kvm_arch_vcpu_create(), which is called before the file descriptor for
> the vCPU is created.
> 
> Fixes: dafd032a15f8 ("KVM: s390: move vcpu specific initalization to a later point")
> Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>


