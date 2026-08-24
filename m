Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F611D63E4;
	Mon, 24 Aug 2026 07:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787555726; cv=none; b=GeuYQyJiLgOcnXsL7Qa+lr9LqzB8grjVD8gY6oZHRekHk4AgjhZyUPiHd0UDYEjGYFKNlvBherZmGZyeZUduBXrBEOgmzmQY3U0TvaP1Ik9DcDznpKSPuF8clyL4CW58LBh2rvXrklY6mrDMsgUw+eswU9BhKUDMmLw6E0Ol/PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787555726; c=relaxed/simple;
	bh=t8nswsNBaJpU/DtC2ufgweGppB2rKtfMQsRcyw+rzUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TyRxYm6E4fVGI4BEaRnQSnyqNMA1xIFzMoovJc3HB5TFNkCO48T4rAn4MypcD2Rn3kZv3r0r8GBfWIjPaLmYbxBmhsdAniNSKR2sgGlt6MnXNg1vRb3Suy6dv+VeBhiLIWmMsdIcwBSuftYI9VnekQ4QPp6FuDwl6uKDqks26uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DXw5Oz9q; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DXw5Oz9q"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O5VauV1014032;
	Mon, 24 Aug 2026 07:15:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=t8nsws
	NBaJpU/DtC2ufgweGppB2rKtfMQsRcyw+rzUM=; b=DXw5Oz9qNrtaVOzRG9SMfb
	Mt/Irhy9PRol2/G9JMnKhRCAgJ22rpY7z7TZNN5GziIIVUuI33YcoVfvwSN7J/EK
	O7FWDgMt6wTiCtQq4mwodCvodbo4PpjKuiYTfchJ61G8EYOITZgKke3x4VaVURgo
	OTrWNjfubA8YCMwRKXnv0sqEk9XuaKFiVQ/1mNnZVC8NdUbU+PL/OYmGhIzVnG+t
	eNu3ChrgZrrAq/hPTlNITObBcNbLjyAnobAw1KxkJ1cXuNr+WAE+tZGzdAIzglyh
	mSDMiHzKaDmupg8Y4dXur6sXdySfsGBhcTgneQrnRRRMaUZgkXTzDbqbLS2DIpWA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dwyku1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 07:15:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67O7BEIE022221;
	Mon, 24 Aug 2026 07:15:16 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3pvqc3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 07:15:16 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67O7FFI926411734
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 07:15:16 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8D8558059;
	Mon, 24 Aug 2026 07:15:15 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54E4A58043;
	Mon, 24 Aug 2026 07:15:10 +0000 (GMT)
Received: from [9.124.213.220] (unknown [9.124.213.220])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 07:15:09 +0000 (GMT)
Message-ID: <b4f836d3-d909-4228-945d-b11231290725@linux.ibm.com>
Date: Mon, 24 Aug 2026 12:45:08 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net/smc: fix clcsock and lgr/lnk races in smc_diag
 dump path
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, alibuda@linux.alibaba.com,
        dust.li@linux.alibaba.com, sidraya@linux.ibm.com
Cc: pasic@linux.ibm.com, horms@kernel.org, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20260807081606.3200128-1-mjambigi@linux.ibm.com>
Content-Language: en-US
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
In-Reply-To: <20260807081606.3200128-1-mjambigi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA2MCBTYWx0ZWRfXwqjBnH9jN1WD
 /Wd8ZIUtLMGVXAvXyFze/u6nc8mfCwNq7J06EdbPUgKSD7UWJqTpdNEnLa/n1KB7YYX/1ONcIHK
 xTanVgii1JFXMFrbk3a/1f5NuvkbLi8=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8bef86 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=1vQF1UkLROcUZo-dBVkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: of2Cm08DmUC2OwBgVFdayGll6y8neaBD
X-Proofpoint-GUID: SqIgg5iKNswZMbwmUDe6UEosHU1c_YHh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA2MCBTYWx0ZWRfX31N2DwuhE26k
 SbHFz7n9tDtG/qr/shRdJkpamM6d3LRISUiJlblmDo9sbzlDlhMoaf8RyAK8mD0eEK7tSQoTUJl
 MMwjE0+YB//mf1gkuo3dCPkwyK5BZrQkp2hPaUECO59NwtvkjiJ6eg+tkGN3Il0+HxXU/yijHXQ
 dOB8lEuHqSyRmTuKTNG6e5YF92UgmzqfW9bp0bItAlnbJ613kTnFEVdCLrBjWjf4oZdsePmCzjv
 9w9gqxoe++wp/Xn4t3rXHAN3Eh2EqZquCqzp4uQ+wwi6Cch5wRLEI5FG+orw80Zi7JFZ+1n8YB5
 Sb9rxmiiIUyGKa7Qw02q0zkmW9rhEqm0JDF+cwxkrgmVvyqY/vaaEdDjG+E7ThDdkmmZBWtPrqb
 kakArlviXAebps9gPzR1XBv4RUvukPdWuecPYRZGsaKdwiI+lEukVZVz6A/ip/RFY9KOhC+BOQU
 ZMGjKZ8zlO4NATAlLTQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240060

I am currently addressing all the review comments raised by Sashiko.
Once they are resolved, I will send out a new version.
