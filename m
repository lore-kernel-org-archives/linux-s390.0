Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F87737E2FD;
	Thu, 26 Mar 2026 14:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774536552; cv=none; b=G7HVMdDBaK/9FKFfLhtaRbwdi7Cbm4bQ5CLZ+wPNvy+ba309trrPT4I9Ghea4aw3Q0Rsvcttp5krgP7HX/floCBPm08e16sWxHDUkzBunagBUcyt77QiJkB0XQfiGk2ypd0lE1uzozcaUTnYmZKpRMVCxJDHG24P5Qq7PwTERzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774536552; c=relaxed/simple;
	bh=r1H9W7VPNRX8e0ooNXQUZ2CxbJTTzUwVCl1kj5blLlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q8i/yoQD9chm9UPJahZh96sLYSYs6LjC4MdgNp0jAfpfOQclzjYjrxwP4jRbkB8Kql86qVc3OGwiA22cl5DMbSwHzU9iZbOg4hqlEZU35d6W0b2OoiKBYs1MNxuaiRGkImKT+/RCPdyJ/WY4ma8+MyoJj0tV9GwNkCOACUibNio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jsWkEHlo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jsWkEHlo"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QC0Gm93819926;
	Thu, 26 Mar 2026 14:49:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Qd3OxW
	CJ+JuGavIWWTTESE5Y6IqoXtMz+GPv9NvAJvE=; b=jsWkEHloVw4924W1d2JNBg
	/ITkl5CBA+CtRBlNgl+jzEf+GYL2NgMrLGBAeNWy8Mc4bSjUDccRYvbvXoZ88X4U
	sJ7VjeG+GvThkSYRmDbAXmjmkM800INJeb4+Kk9QHQg02TwJ3U7mF+cAxEDMoGa5
	RojXci8mVXQx9WFKLJNMC/Lxb3TOXj5S3UQIcmJeCKTwDmFqNCwRhgTfMgbJTyf7
	wuSiT2rIAvaNUr/IHldsWpC5ZV3mp4eC3TUmTzNVB/QG9E3zOQt2cPYi/k1jLIzF
	BsuXF4w+S+G8JOb8JAoiM6Y7bosZY6ksot4llmMHwVdYWLpjlCQOkOV04Vs/eYuA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kty5pby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 14:49:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62QEh3B0031598;
	Thu, 26 Mar 2026 14:49:04 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d25nt3grk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 14:49:04 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62QEn0U329294962
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 14:49:00 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6546120043;
	Thu, 26 Mar 2026 14:49:00 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAC7D20040;
	Thu, 26 Mar 2026 14:48:59 +0000 (GMT)
Received: from [9.52.200.39] (unknown [9.52.200.39])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Mar 2026 14:48:59 +0000 (GMT)
Message-ID: <f894d3f7-01a2-46c7-b2b0-5933919dfe98@de.ibm.com>
Date: Thu, 26 Mar 2026 15:48:59 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/10] KVM: s390: More memory management fixes
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        frankja@linux.ibm.com, nrb@linux.ibm.com, seiden@linux.ibm.com,
        gra@linux.ibm.com, schlameuss@linux.ibm.com, hca@linux.ibm.com,
        david@kernel.org
References: <20260326131719.98229-1-imbrenda@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20260326131719.98229-1-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqITsb/g c=1 sm=1 tr=0 ts=69c54761 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=H4Np5_ecnopd_ErY5ncA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEwNCBTYWx0ZWRfX9Ll8vG8NatPm
 sT12pSsg8MePVbxRoEdHnM72/d73fGjp3pcUJgRSokAY6SbyjrYLm9CZHzGy/MIO4BrOdQl4sBF
 oJDiAYuxg8Y04bEe57Kq4vrPNwADXgliVMjFhuVIu80lKhPefzCrw/fd4j+iGyjXVLd2AcBi0tt
 v+W0Hwnb1DRNFXuVyvZdDkY3LP2CDUaG2YaKF7GWXhQjfPr3J9jtQEa7G2Z4Ck8hmZiwC25ulzD
 k9m3+FraqOdA6jKr7Vn4LmvmwC4SPDrTUBrXCoEaIADzF0eNOVoWhFlzofT1ZhYbMNERbuYuccO
 bdi2kVjPGoLQ7R9YDskO69/JYSxdyeTcd+TmavuSnLC4NFkp/yGNtjnDpIk6a3h0Ri7qtqeUADK
 5cyNItZd4w4xVsoTZTaXMzjneIr1KlZE410lt7RGkvcuFD0OFNpjlCzjd219jGFfZ7jUstxJuSc
 uSnLW9NRSh/jtflZDUA==
X-Proofpoint-GUID: x09bbc0zZmstP82Y2GPM8aVcAmt562cx
X-Proofpoint-ORIG-GUID: x09bbc0zZmstP82Y2GPM8aVcAmt562cx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260104

Am 26.03.26 um 14:17 schrieb Claudio Imbrenda:
> This series fixes some bugs that have been recently introduced with the
> big gmap rewrite.
> 
> Most of the fixes are related to vSIE (nested guests), although some
> are more general. The last patch fixes an issue introduced last year.
> 
> v4->v5
> * Use gmap_crstep_xchg_atomic() in gmap_handle_minor_crste_fault()
>    instead of dat_crstep_xchg_atomic()
> * Check the special bit in the new pte and crste, instead of the old
>    one in _gmap_crstep_xchg_atomic() and in _gmap_ptep_xchg()
> * Fix handling of pgste spinlock
> * Handle more unshadowing events in _do_shadow_pte() and in
>    _do_shadow_crste()

Lets add this version to kvms390/master. This already is much much better
than the current 7.0-rc state. It is hard to review the differences and
we want to get these fixes queued asap. kvms390/master is picked up by
next so we will have CI coverage inside (and outside) of IBM.

If something is really broken we can refresh kvms390/master, otherwise
we can still do followup patches.
