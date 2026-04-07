Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B24D3932CE;
	Tue,  7 Apr 2026 13:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775567133; cv=none; b=fv9E1HvEj4gDsd9eC2gzLDFc3DpQujsxEM4jZYC/LPY9d7UnvbhsU3TitshFefE5S+CwILklKpkIbj4/rVmeSdYsUDgMOvIl7+xxWhkcxukPaPSTPzWWM74jHBeQWzzVNJDGUKG6cGTTlnYzAcjOUuAM7CRpb5d8QPUWXDUKbXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775567133; c=relaxed/simple;
	bh=7d0NOwQc5CI43z82BgMaBlClXDvITwxx8bgqSVntNj8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VL11twetVPxuxnultPRcOzqJv2sF74sAAJ9LWuO4u7AcQ72R+VeRew1RECI3Gxbxe2Sctp3Rz1SC/fILl2bYLYE4WQrqv7Rj+Ps/EWLp6Cn6hBoqjLzof47HdPFxW3+JSnDp5gi3Wno5tHbgJ4AsXJGCu3ftZM3R1eA56/e856s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bVlt/+FM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bVlt/+FM"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636Lm0XD2325933;
	Tue, 7 Apr 2026 13:05:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AHg2v0
	hs8mpa6fbGF0OoWEc9QEzxM+NXIvlTtZZTqEg=; b=bVlt/+FMYrjU+ZILXeriHb
	LID5yJcS/vEVUOetzL0BaPGTusGnBFGxhj8bXGMxm2sjRNPUJtYwLXN1AMnUjqgM
	edQ40Nh99XR9xKa/8fgROL84v451dNmdyVporrt7PPFwytqzyG116JHfhus3aP0V
	ZCaQppXX5luHncKhZrvdkLNy9egmhY9PY09tS834J8c2brxHQfxwfFyHmBfoD0qt
	AQYBAqUclJ71Lt3GxiiM9cXO01TZRe9gmaOEiHiyfyb4fXSh8LiS9CnjLfYgjHuo
	3Hb3OAzISPlqoHH8cB3loJqPVJTi+uVw6eEy0IT9qxy3QxfEc9ysh46oavNtX9jA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2kat3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 13:05:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637BHrxP018952;
	Tue, 7 Apr 2026 13:05:28 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcme9b8p4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 13:05:28 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637D5MQf50135488
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 13:05:22 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE7AD20040;
	Tue,  7 Apr 2026 13:05:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B9BE20043;
	Tue,  7 Apr 2026 13:05:22 +0000 (GMT)
Received: from p-imbrenda (unknown [9.111.4.78])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue,  7 Apr 2026 13:05:21 +0000 (GMT)
Date: Tue, 7 Apr 2026 15:05:19 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com, david@kernel.org
Subject: Re: [PATCH v3 6/6] KVM: s390: ucontrol: Fix memslot handling
Message-ID: <20260407150519.65093fe1@p-imbrenda>
In-Reply-To: <20260407125535.296205-F-seiden@linux.ibm.com>
References: <20260402150135.196943-1-imbrenda@linux.ibm.com>
	<20260402150135.196943-7-imbrenda@linux.ibm.com>
	<20260407125535.296205-F-seiden@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEyMCBTYWx0ZWRfX3cCvzpinOKFq
 NscMJZwk30MvZD75w8agSx53aFgx8OTsMqdUjGIa4IG838f+p7pJJNHFESXw3rI649xaHcfIj5J
 0tHfYS6+xKDPLzc7vaxQKaC5DtKAGelFiRnphrqe4qKwbTom8kI70QXQSdPQsLQrZlB75nM+qcw
 TYKfnAVqr+fgIZ6KegBieH8KeSXlQdj5CnV4PbeD+DR2kePQrEufUPDU3XiFddjTVytf8nqzOLf
 bmdyDLeMfIdtXKILEVIUbwrRUu3NXe097WS8MwsZuwFjpMaBvrZx7O30LG3Q8Dy1hjst1dLoqSm
 cI+mxEfAAQNqcXDGsCxGINw5UDClDldpvVkRi+fZdOzHraxa7nLV+gtADMBrj9q61Q6hc1tCOIe
 5M593HlgkgQxMi3xbXgwWv+vlO0H84WkpbAza/Lka6q452Ifv2d4xJY6H+c+SwfmTpDyIobOMUC
 0QvOgnibEWU2fLbsF0w==
X-Proofpoint-ORIG-GUID: Ml4-WwNd9Lw8osk76_nqgyfN3jFhfNWK
X-Authority-Analysis: v=2.4 cv=e9k2j6p/ c=1 sm=1 tr=0 ts=69d50119 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=GqEPC8PSID6XooUkkPMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: Ml4-WwNd9Lw8osk76_nqgyfN3jFhfNWK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070120

On Tue, 7 Apr 2026 14:55:35 +0200
Steffen Eiden <seiden@linux.ibm.com> wrote:

> On Thu, Apr 02, 2026 at 05:01:35PM +0200, Claudio Imbrenda wrote:
> > Fix memslots handling for UCONTROL guests. Attempts to delete user
> > memslots will fail, as they should, without the risk of a NULL pointer
> > dereference.
> >   
> 
> You may want to spend a fixes tag:
> 
> Fixes: 413c98f24c63 ("KVM: s390: fake memslot for ucontrol VMs")

indeed, I will fix it when picking, thanks

> 
> > Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>  
> 
> Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
> 
> 	Steffen

