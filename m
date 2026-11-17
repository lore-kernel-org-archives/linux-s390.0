Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794930375;
	b=hum2WkejU3AIH0y2CjAfLYayvY3+lf2Rj2YKaeL8kUpsRWDMGTQAgCX19KNGvl9QJoPL
	 y68N6fbggQgZ03+Anj7RfWmwNClLPtadht18qkWDotKzUcJsf7S6kVnPAgM+Us58XwOZU
	 hRYZV4A/ZkhJ/SSegNU0Dys2tnOdXHno2+BNwFevQbl5Dp8S23JRmHimCjGTwJLyUBZVU
	 NFHt1NpuBIquS+jdHtSOdYPkx5zgyy1eei92i5dJLgU45SJbINlek0xSaS1dm45kV/HsR
	 3kxFFVgsLGb9E/WgK1heSqasbChmV7joHWwZinbYy/wD+HEmVQZYLkBK8L//w7UX6fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794930375;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=YpDRUGFhJbMY8cFS7kHl4bj62XJrRWTYgu6F2NW1qJo=;
	b=keecSgM4CmSeZclZKcSa1lBGWJePfgHd1P2X8ueicnHIU6DTIQf8PWivjikeEvUHXi11
	 FnFoWoWZoP4+Q8kUpSomUcopXBBN7Klw6/1NhJ4CPcC0MI8VNPU5K3UYy1QQRTRzIJWgu
	 uHMLaax+QHySWbHkPoBZd3PAAIY3oKEz/m3AmsbY2mbC1Bo6a30WV/LB3Ysjlnm7riCAK
	 FGDcRm55Pf+yYJDtRGcGECgZQScM71IH2VQrKqkwV7sSc24E4GQczvK9zV2ROOmQKk6qB
	 qSY+kOA13+bUZZT6qsqwKYdJra2R9f7dfvt+nNT1/qcj7pke5FIBbQjA7qbK39rOjBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NtsmqgWV;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B21606A31C;
	Tue, 17 Nov 2026 15:46:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62B21606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NtsmqgWV
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHFQcTX2892676;
	Tue, 17 Nov 2026 15:46:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=YpDRUGFhJbMY8cFS7kHl4bj62XJrRW
	TYgu6F2NW1qJo=; b=NtsmqgWVeXYOAuXj3snk5SA+Ch+hFIJ2O7PxbVWAB30OMK
	D7apu4PSjR6sNkNnfDKv4AfyHl7IjfVMN8NJrHPQzkw9mXlNqX6mUutm/5H1qQap
	C3RWo9mmDopPUvsM3PLnibBHSy4JDTATWSrpcudUDfEHQOOcf/DZ8ip69f1CilK2
	nNLnrqUC1OE9Sn3lGT5CDHBYgo9tpp7n+EUgnwX6jaYg/ZeHpPyXMe44XdSamltG
	p2LFge9cSQgDgcLCfU/xc3QgM3E7ejtxFebDnriamGmoxtCHNcTg5jdnhNcP0giJ
	LHGXOq0ywrYxmEgFFtff29IS0SxRelJo5paph5cQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxf56c4fq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 15:46:13 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHFYuCn3749361;
	Tue, 17 Nov 2026 15:46:12 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j067nc9wm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 15:46:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AHFk50P40960298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Nov 2026 15:46:06 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C87AA20043;
	Tue, 17 Nov 2026 15:46:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C81A20040;
	Tue, 17 Nov 2026 15:46:05 +0000 (GMT)
Received: from osiris (unknown [9.111.0.235])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 17 Nov 2026 15:46:05 +0000 (GMT)
Date: Tue, 17 Nov 2026 16:46:04 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Anastasia Eskova <anastasia.eskova@ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        keyrings@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 12/15] s390/cert_store: Validate hash length in
 check_certificate_valid()
Message-ID: <20261117154604.32016Eb8-hca@linux.ibm.com>
References: <20261116143534.158375-1-hca@linux.ibm.com>
 <20261116143534.158375-13-hca@linux.ibm.com>
 <avtZGgO0DtD8Vn9Y@kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avtZGgO0DtD8Vn9Y@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA2MSBTYWx0ZWRfX7/cIcwyEsqqQ
 qvWXb0EvMi1eQIVi369DuJju98ahAN8u8bCUTcwZzjL3rx3kdVUUR5IPQ6lrPPH1skQG2LZee3T
 JKV5mmpX0VK/hwIQbKu6kto7q4sWByQ=
X-Proofpoint-GUID: 67aU_ZNweYLcgz7coMEpRXuVopdDyOmi
X-Authority-Analysis: v=2.4 cv=ROImjIi+ c=1 sm=1 tr=0 ts=6afc76c5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=aU34bHTWL6dLNXyhpOQA:9 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-ORIG-GUID: 67aU_ZNweYLcgz7coMEpRXuVopdDyOmi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA2MSBTYWx0ZWRfX/XzbnKYVa+4A
 XmhY0n9xgtyfXrhBsE6zPwp0rcQnznzuDsXCUZ7Nm21ppCDgeF7W7O7nPcoTQB9Ykp1Y0C4iHor
 8Mdg7+DJrqv1ewDuu7xq789HM/Te0Zx9H6CVoNOATu9NDqgjfGckz9lE8Y5SYAeWgpMUzfbqyR8
 G75loY3OwAn+g43K+0O5Z4k/soWONE2QDYneSJ4rxtXEm32CDegLbn4ueSqbRJW6U3BqZb4pKjL
 M5/+c82hIpXNb/o9vnJyNLUJhNTdOBpOxKGdCNwNsB8/5FkeR7CGfyjRGSUVznZ+vA8WUPJlAOI
 V0q6Mx32dJIngeOYEnrMCC6e4tadQIqvWggj/fJ6NrDLbK0oa0B7hGkKAIoSUSs702j8oNcsPgV
 bH/3CE9h/pCxFBB3MqF7wVEHm2hwupNbhswlzkUr/7vKV7rc1EPW8+WaOxFqPloEBpAOpxhP5gQ
 qRrauit5xrXIKYR9ofg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170061

On Mon, Nov 16, 2026 at 09:27:22PM +0200, Jarkko Sakkinen wrote:
> On Mon, Nov 16, 2026 at 03:35:31PM +0100, Heiko Carstens wrote:
> > Validate that vc_hash_length is SHA256_DIGEST_SIZE before checking the
> > hash and use sizeof(hash) in memcmp(). This avoids an out-of-bounds
> > read if vc_hash_length is incorrect.
> > 
> > Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
> > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> > ---
> >  arch/s390/kernel/cert_store.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
...

> I'll stop here :-)

Thanks for taking the time to review most of this series! So, I guess we will
end up with this series going upstream via the s390 tree. This will result
with a larger merge conflict with your "keyring_gc" branch, but that can be
solved of course.

Is this the way we should proceed?
