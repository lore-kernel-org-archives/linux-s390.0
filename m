Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8705B349B15;
	Fri, 10 Apr 2026 09:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775813132; cv=none; b=b4fErqMz8WSsTa7iHCctmsscb33gc+lGbfsD0f4J8fcyv9+ql0rBoWxbAkUf77ZZJLY0N7b17W1vvEJxmM2N6yyvjHzyRuJWlVDM49yqjAxQxMSScEqTz7pUgu0WQWkQye1ggaCSvyjaecvQHTfG0BhGGqxV1H/KI6bFrTdPGFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775813132; c=relaxed/simple;
	bh=xvIvLfRvvgR9oqgnAvaMPEAZ0E09bUp4Oq3+oP8zASQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:From:Cc:
	 References:In-Reply-To; b=oc2u28DZhlKiOFWkxcNLHgJEG0bIRsTr5fgZMQXwuGo2OSLI8IxzRR9AKW39/qi9phvDUXNGfYleoED5hLc4I99vKuf/hCKNesgJ06AVz3xVlaZHrjaS/y05shDt1Eq8YYkLpZbafHrGjkXfCmqYRGFw1OhK8nO9BORGCMo0y7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SBl5loVx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SBl5loVx"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 639LP1iN2210133;
	Fri, 10 Apr 2026 09:25:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=v2ujTq
	3KQ1wTTrwgHAAh+90t3+KO5r/w8/5vCnOniK8=; b=SBl5loVxVGe+SwN+IWpM0C
	mjgLmeEwkbXWIFl0ZU/CHnPjzyGa4XBnX1NQ3Ebab6A06Za5CvochC7nT3epvlTW
	ogs1KU0OoGYt+OPAsobIXXj+N9XB2I+2vHwL37aGzXPzstFR7m++ifcmhhPNNjyS
	UuxIj7Z7y91P1j0/FPCwFWA+SnA0uVtg4GCjtBRZ9Zks3FTmp9k6DqZuCu8JqiXf
	Yq7CF8bVQ6PoduHm5T0bDyXl/CWp5LMBV1z/kLYQFiNH3Watq3wYbKhM7hHMIJ10
	BU7bmOG0SLz8GFoZ+m6QrxcLKOQwikhS7L2NXKA6QtIapgCdMcuwQNenxWszQFAA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2hr3tb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 09:25:28 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63A82gT2019008;
	Fri, 10 Apr 2026 09:25:27 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcme9qbtd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 09:25:27 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63A9PNGE54985160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Apr 2026 09:25:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D583820043;
	Fri, 10 Apr 2026 09:25:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADD6220040;
	Fri, 10 Apr 2026 09:25:23 +0000 (GMT)
Received: from darkmoore (unknown [9.111.44.245])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Apr 2026 09:25:23 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Apr 2026 11:25:18 +0200
Message-Id: <DHPD7OD5FOBJ.38Z9OAZFKNYMU@linux.ibm.com>
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 6/6] KVM: s390: ucontrol: Fix memslot handling
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: <kvm@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <borntraeger@de.ibm.com>, <frankja@linux.ibm.com>, <nrb@linux.ibm.com>,
        <seiden@linux.ibm.com>, <schlameuss@linux.ibm.com>,
        <gra@linux.ibm.com>, <david@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260402150135.196943-1-imbrenda@linux.ibm.com>
 <20260402150135.196943-7-imbrenda@linux.ibm.com>
In-Reply-To: <20260402150135.196943-7-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4NiBTYWx0ZWRfX8zKjC8iYDCua
 +aiQMimgFXWsEWGEEQQGsNBvdWytG2cz8wpTflA9bOydx6ltPkJDIDIEl8sP0qIsDqPQALm6lUY
 g7OuIjls+UFNkdG8Q3tI/2WMVA6slx6AVdo4+Sdv6FkFYuQedMDTCWr2apqV1V3ZiVhhx6NlLvh
 AiWjR+CtA5/8Y0p2PuVo41Y4szDYRmL6+uTK7fxa6vQPNTGszEhhM1M7zrpiTZ9TE6ruROG434k
 g3j8V9Gz9x/uAUSRliXetpvuDDyZNS/+QLTOKDiTvGkW04W36Ew2sG3aW3pJccvTpIJ1xqRz9iO
 3BKnQCuxE24nNM8xmsB7/8MsJvi/QPKScpRmlOChdbcgOCu/E2pMJJNnDb3GIc04JkP6ruL6h/k
 bdufYW1yB+1KSEWfNdarSw79gZ5Ljz4rvDgftR2d2zRMPoUqWyiPP7Z2PLeUUJA9Jv122ZMpfn7
 TGMmXyFyPoMa4L3pkDw==
X-Proofpoint-GUID: TQunE0BzxTShJtrKEnVpCjAvlf6EnNiM
X-Authority-Analysis: v=2.4 cv=a/wAM0SF c=1 sm=1 tr=0 ts=69d8c208 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=l9Vu-cA8k3pwYmh6EsQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: TQunE0BzxTShJtrKEnVpCjAvlf6EnNiM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100086

On Thu Apr 2, 2026 at 5:01 PM CEST, Claudio Imbrenda wrote:
> Fix memslots handling for UCONTROL guests. Attempts to delete user
> memslots will fail, as they should, without the risk of a NULL pointer
> dereference.
>
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

With the added Fixes tag:
Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

> ---
>  arch/s390/kvm/kvm-s390.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
