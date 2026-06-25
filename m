Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA7E3CF698;
	Thu, 25 Jun 2026 10:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782384135; cv=none; b=b2apzqAY0f6aG830TVbVKoB2UoKWPM/q2FeZTK0dT6dGFk35Chr1Jk7zJOTWtoyezSGld09DSekvysbbpQk9pQwLXNWMrD09r2aHChk2Os6p7aINAfnBCZYRjEDnSDZMc5h4nmZFez+xtvAhdTR4IKxbIbzw2SO5nLGFOR1/Keo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782384135; c=relaxed/simple;
	bh=173lQ7jzJnbBLvffNLCqIOWQQGAchmqsaB7zv7/I9ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O0VIWstFnj+pS6h4uMg5RaZhk4jEGmdabF38Ez0Bz6vZbjqAOi3+BgTNQLlr8AkSr+4ykyPdn2Z2Xbc8rdvKNJ3SLqLStF3MMNtLTtaYXKe1lsHA/Ico+kCRFWIpFVSzWWpJ4R6Ak9QDKVvby7pQmJuVVVM7lqsP/JoV4bl6608=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sqCPT31B; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sqCPT31B"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P3nsih3188232;
	Thu, 25 Jun 2026 10:42:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PPxrq8
	Mq/VZpa22VlH3o9x7wplaq6waAQx3XOI0U4Zs=; b=sqCPT31B4hnuP8UVwFvpyj
	qvDhd0wai3xHDNBOyTnLqg1VwWA/KilXk0dDeWuweJAIigoj5GS5cNEjgKbgyyYp
	GrY+2wRemn7pqVyAq7MYOdVikkb0v3zquUrQUelaqBxUl2nblZ+Nybzxk2w8VkMK
	8bobw8sXXidwaf+ZxOrTqnNmXlC18gKMqvKALZo7JMJKIXCvW/1QzfenM4Q2NuZA
	lbpT8+T8dobQB2L07XY1BVGfmzDEAbSLFvr05hhRsfonbGWHyM7pEk5PXwl7wopo
	VVs9pCN0johp/FJMhq8UAOfavmo/aXm5o7+Lx/JvhR683rPEKBYDWEaQbXYo3zhQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjhr15xa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 10:42:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65PAYpIF003558;
	Thu, 25 Jun 2026 10:42:08 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7dgdf2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 10:42:08 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65PAg50a31392166
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jun 2026 10:42:05 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DB9820040;
	Thu, 25 Jun 2026 10:42:05 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D29BC2004B;
	Thu, 25 Jun 2026 10:42:04 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 25 Jun 2026 10:42:04 +0000 (GMT)
Message-ID: <9b05627e-abb8-447b-afd6-994045ccedcd@linux.ibm.com>
Date: Thu, 25 Jun 2026 12:42:04 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] KVM: s390: pci: Fix GISC refcount leak on AIF enable
 failure
To: Haoxiang Li <haoxiang_li2024@163.com>, mjrosato@linux.ibm.com,
        alifm@linux.ibm.com, farman@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, david@kernel.org, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260624061910.2794734-1-haoxiang_li2024@163.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260624061910.2794734-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=I4VVgtgg c=1 sm=1 tr=0 ts=6a3d0602 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=Byx-y9mGAAAA:8 a=VnNF1IyMAAAA:8 a=5fjQyjqO7ItlhYJTiW4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA4OCBTYWx0ZWRfX+lEBWXtDF8RP
 iy+Kl2hBQSR6SZa7E4vGA0UvkKxvYXca5XBm7jdvV3RHTmYf1Pzi+T2Nw8EK0TwtBqi0Wf4i53z
 9a4f4+dTunkUXCbsS6HdSsUWhUx1PkwZ4lRfs+CA8aQeplaZWmPgSVKGCuTGI9K+1AOj9S0cGTj
 5XkkgD55Lfp/gxNB2Ze48MKxlcUU53My6Rp3II3EYQ2aT1CkR+kB1y66nQ3thpuwTeSa9Ao4Vm3
 E7W3m1T6zPkgz9ZlhEAwGtPPMxnZ50XFFDR9w5OKNykSWw3cpAgRcZmxI30BuvFEToJrO6KMpAz
 Y1Y1puBQ2at2SknYFvHsRzqUs7llWJOWBt+jUXlM2R06C2jVej9z/gZUdSUGk0XOADNmVCtOQbg
 NU1BW8o1Z4CIY0xiq0ja+MqHog84MTDoi8fuyy3iS9CtwlV79B0sBapvOjoZAOSD+K5fEpxMaWw
 tezoo9pnh2nFWIvUZng==
X-Proofpoint-GUID: 2ZY1oorcYXfgmBh7E2HeWMMeHiSJwrU4
X-Proofpoint-ORIG-GUID: DC6bkh7qS0SbxJMK13wVUfykDy0GfR4_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA4OCBTYWx0ZWRfX2flGIkIQamr7
 oxwae893OWC2w3olmEux6PP5BnRXhuZ9Fq908kTwByJ8vtAu1cvoPq9SzPycfKA8oFs/F9Qd7nk
 rc0KikYs0jlBQwsyygArsVy0EhB8gSQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250088

Am 24.06.26 um 08:19 schrieb Haoxiang Li:
> kvm_s390_gisc_register() registers the guest ISC before pinning
> the guest interrupt forwarding pages and allocating the AISB bit.
> If any of the later setup steps fails, the function unwinds the
> pinned pages and other local state, but does not unregister the
> GISC reference. Add the missing kvm_s390_gisc_unregister() to the
> error unwind path.
> 
> Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
> Changes in v2:
>   - Move unregister call after "out" label. Thanks, Matt!
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>

applied.
