Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5006D3ED11B;
	Thu, 23 Jul 2026 07:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784792018; cv=none; b=TTqhOLSm3dx5oxSWKHLTIPqpKuk9bZikO73aK/RWvD8CcoarwSm7FOFubPDBfPh5WZWPZbvQNYa8x3olzpniWh1lAuQAblo56yN52hpNfn6o/jD7MrEcju9vE71ywUr4441zc8EuZ9DAkOyOdv3WZiLiT5DPzHnrdeN3JsM2jx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784792018; c=relaxed/simple;
	bh=oC7sbdUgNMV8QTYtSsP43klCwlgDf7B5XZJkVhlnl7g=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Cc:To:Subject:
	 References:In-Reply-To; b=kO7RJXFVMHcSsn1DJCg2O6g/hh/r5Qphhq8vQjg4PIQ4Yf9PF6NYmyOr59jZFnfr+gdRTu3nkxzPygeskj8uvD8Jb3T9Nb94VTpzh10G+I0RVw/SqTZ4LJqo7OXxivNHzVsm5sK1krRfMBdoMrLD/U0eKROxrf+DpLYEjm9dYdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=saIVXHy9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="saIVXHy9"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N5CjK82084695;
	Thu, 23 Jul 2026 07:33:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mt3U42
	aN626+U6dkCBBEqQUPL9hveoK+KDmxcgBTv6Y=; b=saIVXHy9fBGHE5U+39KXLY
	lSQPMMlZ2MpHhRYUcMJhpSRW0CuiFHxzWDT7cSJwAifq+qmJQDcdzI8DewwcwImY
	K+qBqC5sZha3ywdqe43l8WwFkYT5og8ik9WB1PKbsnw1bQQgzDwYlrx0ccrQVVrJ
	qJKiq8YRiKZ+gq+RXIHHsFbQQadlNcuFRN78vCxoN4OXQJt8yNsFPmJhBIRhrlYL
	40cNPc2EiPkI1exp9cptaCIjxqqxWb0TeInKjoCVzCw3IO05496msfHbCDq+qFdm
	sQlHnl62NtANVwVBBP5Uu6CrzuICgLTQFq6eQ0wo+AlxnWBsO/nbrLf3QpTFoZhg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7916b90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 07:33:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66N7JdB9011886;
	Thu, 23 Jul 2026 07:33:35 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1gjvwv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 07:33:35 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66N7XVpv41681216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 07:33:31 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80E8120075;
	Thu, 23 Jul 2026 07:33:31 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C77E20071;
	Thu, 23 Jul 2026 07:33:31 +0000 (GMT)
Received: from darkmoore (unknown [9.224.78.25])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 07:33:31 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Jul 2026 09:33:26 +0200
Message-Id: <DK5RYOJDRPYK.1UBAUE8G7YG75@linux.ibm.com>
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: <linux-s390@vger.kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>,
        <kvm@vger.kernel.org>, "Vasily Gorbik" <gor@linux.ibm.com>,
        "Alexander
 Gordeev" <agordeev@linux.ibm.com>
To: "Janosch Frank" <frankja@linux.ibm.com>, <sashiko-reviews@lists.linux.dev>,
        "Christoph Schlameuss"
 <schlameuss@linux.ibm.com>
Subject: Re: [PATCH 13/21] KVM: s390: vsie: Add helper to pin multiple guest
 pages
X-Mailer: aerc 0.21.0
References: <20260709-vsie-sigpi-v1-0-ea9f12066408@linux.ibm.com>
 <20260709-vsie-sigpi-v1-13-ea9f12066408@linux.ibm.com>
 <20260709152820.BA50D1F000E9@smtp.kernel.org>
 <869ceed8-1c04-46ff-aa0d-c1ae5e01badb@linux.ibm.com>
In-Reply-To: <869ceed8-1c04-46ff-aa0d-c1ae5e01badb@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cjnaU2pdzk-Yat43uaq2L_Tn5IgmLLwg
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a61c3d0 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=HN2Bi1S7tktRAlzQxmMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA3MSBTYWx0ZWRfX0+knXjz2XtQ8
 0VSncqCVKFMb031ipOI1zA2MgEoynTSyRb+phrgZYPAWL5wta5uIcwT+c3LgXaIgVO1TTGZYNm0
 eXwDINfS/an/ZFuvuKaEGuVFyrRYtOQ=
X-Proofpoint-GUID: cjnaU2pdzk-Yat43uaq2L_Tn5IgmLLwg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA3MSBTYWx0ZWRfX5q1dYRe+EomK
 zFG9sOTDP9WGnwl07x9sk/j6yigy2FhI9iWGfPUgHQbtchvVd328JmcYLvPiVzcZckBheiEMp2+
 A2DVOXxY9MRCv6Ha8ZjbYSS5k6YLmfV11uHfWDz2TTcyU7qtLjAPNFjG6C6vF+rJ/YATynZ4c2n
 j7rK4NQblxugtYhI4daHojFfONXx1UK9ZiHUmwSZRwwc4hOWgCLgcew5RiiWC2omLDbhp5i1T8e
 C8Ec5owaR2qmtC6keQuEh4nNgYwH+7CZU+08uqSVAKPXMHipYEN25DMqTv7dVIPgnda1aAUScZ8
 VSY1ahu/xfYieg6DcosPZdiHhjNfFQyChe+iUqRHZQDKlJAHE8OWBRR2g+4KmslakbNkOjtPmw7
 qLJYAd+wmYhcqyx5xMM1H0UIRBdao4l/b+teHXGhkfQm9FuEAKuzyiEFfSdoZIXVJlzi5AMza/4
 i+A8BJ+cC6u61wmCaLA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230071

On Wed Jul 15, 2026 at 11:19 AM CEST, Janosch Frank wrote:
> On 7/9/26 17:28, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential iss=
ue(s) to consider:
>> - [Medium] Incorrect address calculation for unaligned GPAs in `pin_gues=
t_pages`, leading to data corruption for multi-page contiguous buffers.
>> --
>
> [...]
>
>>=20
>> [Severity: Medium]
>> Could this address calculation cause issues if the initial gpa is unalig=
ned?
>>=20
>> If a caller passes an unaligned gpa to pin_guest_pages() (for example, 0=
x1010),
>> adding PAGE_SIZE * i propagates this initial page offset to every subseq=
uent
>> page. This would mean the calculation requests 0x2010, 0x3010, and so on=
,
>> skipping the guest memory between 0x2000 and 0x200F.
>>=20
>> Would it be safer to align the gpa calculation for the subsequent pages =
to
>> ensure a truly contiguous buffer is correctly pinned?
>>=20
>>> +		if (rc)
>>> +			goto err;
>>> +		addr[i].gpa =3D gpa + PAGE_SIZE * i;
>>> +		addr[i].hpa =3D hpa;
>>> +	}
> When unpinning that shouldn't matter since gpa_to_gfn() removes those=20
> remaining bits. Are you ever using a hpa other than the index 0 one?
>
> But yeah, there shouldn't be any offsets for follow on pages.

I am not too happy with that. While agree that it is confusing to have the =
array
named sca_o_pages, I still do need the in page offset of
vsie_sca->sca_o_pages[0].hpa.

ATM only vsie_sca->sca_o_pages[0].hpa is used to store the original sca ori=
gin.

If we would want to store page adressess here all of them should be. Meanin=
g we
need to reconstruct the actual sca_o_hpa from something like

  vsie_sca->sca_o_pages[0].hpa | (vsie_sca->sca_gpa & ~PAGE_MASK)

Its only needed in two places in the end though. Other places do a recalcul=
ation
of the offset anyway.

Putting the recalculation in a little helper method and having sca_o_pages
entries all masked to the page addresses somewhat works for me.



