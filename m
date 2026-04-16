Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1A337AA78;
	Thu, 16 Apr 2026 08:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776329603; cv=none; b=Fb+P7+VIFO0GCTJqqRz+V6p61XWq5QxvYrgvGc61iYuHMtqbsNHl+HBzt9aScB//grgD3cnrEVc9PeLYVfjBd0/bDgx1TvtMY+Y7Jz9X0B8ULskODeLCLWqCCOg3mJ+jD88Xq5L4LDRoj4Zyx0MZdPEgQ3pS/MIwXmIEyLp4tYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776329603; c=relaxed/simple;
	bh=S+Rbl+X0eKNTG8cqOejGKkOulH0HGsQZs6yPGed3wJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CC0OkQU5Nd5HjN303QkaxOejdwS0Z2SVw6/mHXp0S8EAoeONf8gbE8hyym4ueGVLL5r9NicCjy/AC2BKkm/IR6llfkA/xbkztAM+umDC4vMkecDU5rq6fBX4L8cEjI9FekAcetd8DyHZ0KVe7tL11KvEdib/61MnX/hvAwJeP0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LmFNq4kC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LmFNq4kC"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G3DUVY435815;
	Thu, 16 Apr 2026 08:53:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=S+Rbl+X0eKNTG8cqOejGKkOulH0HGs
	QZs6yPGed3wJ4=; b=LmFNq4kCvIjsmA6zjpw01HNzk1mCNOZLxcdT6NngxrLmhh
	tQAWc8dQSrupZbjR4xKteSoZIgzb9qt63IxfAKzW8JuiroTtcbjOXkvI33RAeLDI
	5UAyIZtkXRZf8q5IobZ8SSLxMGkQEyomEfYFxWSkmS0FezxRLF2VyY+b/zzcBfz2
	mMwngpo65vpUuiXNFRO2YQxJu3pvNNEHReYB3pNhWzVLDXlInDRU0wYNRVRhU3Uh
	2TPBXFXVlE4G29FTXy2CforiIbf3ylIyDutsoiDuw/w/KIi37BOdEQMpQZ9xDL4Z
	3C9YnJBEs/0Fdprl8VqmP/jBn4xlJG5yizCW6IZQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89kbq56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 08:53:13 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63G83RSO003253;
	Thu, 16 Apr 2026 08:53:12 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4djbh93qyd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 08:53:12 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63G8r9wZ36831524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 08:53:09 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4819B20043;
	Thu, 16 Apr 2026 08:53:09 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C9E62004B;
	Thu, 16 Apr 2026 08:53:08 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.42.253])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 16 Apr 2026 08:53:08 +0000 (GMT)
Date: Thu, 16 Apr 2026 10:53:07 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Ryan Roberts <Ryan.Roberts@arm.com>, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] mm/pgtable: Fix bogus comment to
 clear_not_present_full_ptes()
Message-ID: <65f893a0-bb47-41e3-9251-9e94c9b5c99a-agordeev@linux.ibm.com>
References: <cover.1776264097.git.agordeev@linux.ibm.com>
 <fecfcf70436e267968c1c3b6908e51fe49fd9009.1776264097.git.agordeev@linux.ibm.com>
 <844d4076-a250-486e-aa16-fe5149c9d508@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <844d4076-a250-486e-aa16-fe5149c9d508@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: knDDruZNWEP89G6YdCKHxfnw_NQeOL_Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA4MiBTYWx0ZWRfX7UdMxaHWCy+5
 rd5H87AheMJJIirSanN6C0vVyQMSA9aBWK+oZSXQm3UH5PCbrkJrIISBO+aX1U/ksZFibDW9bu3
 6foM24tTIFai2D5BF14DMdB7ZiTYZ96gzU2ub+upi9Yxxb93Ns1u0TFrpN2jW1EIS43sMhwvyri
 AriVOUOdAEEccCvYXNTw/9bf/d5sPvD9pe31Ao/sop23EgKTL4dxfs7spFApAj7y69dnw7UrNhL
 iK1kLdGihLI9ZApenG1AbfuPlWK9prgO4azwyyuJpcfC+C0GEy3PGi4mF2lW23mm94oeWIL02p+
 eAFBki1V7pMJ8YByUtOxGDJ81LRmQ7myuJBAjJqiKAa41tESK37DbvA2fMmWbm69lzZtLSKE1oZ
 9zXwsk2aHOSxz886OcpJQu0OX4A2hCnSp7kuyNPmUbKfdCdO57QStYjxBnXZwcqv9E5gyYcLAFI
 fQ27qbEk1P5Hvqyi6sw==
X-Proofpoint-ORIG-GUID: knDDruZNWEP89G6YdCKHxfnw_NQeOL_Y
X-Authority-Analysis: v=2.4 cv=W60IkxWk c=1 sm=1 tr=0 ts=69e0a379 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=m-HIIqDQ52j1SHMWbkUA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160082

On Thu, Apr 16, 2026 at 09:58:47AM +0200, David Hildenbrand (Arm) wrote:
> Talking about pages with non-present entries does not make sense. So both changes
> are wrong. Can you find something better and send that out separately?
> I don't think this is required for your series, right?

Right.
