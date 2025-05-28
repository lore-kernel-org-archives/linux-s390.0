Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD3D155C88
	for <linux-s390@vger.kernel.org>; Wed, 28 May 2025 10:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748428710; cv=none; b=QbXTE74rm/vtCjNope8LRNqBVL8FAjJa/pjeByWzEgbYeB4fI3/nKw85eTBPB6oMgo8orGSIqdK3tTSVJ6x56qyDdgDOu9arGNF2DxReZZEBrdYKIhSH5OvqKA/yFz6DmKu3SLv1nc8fY4jj2WRap2aYBZB8wqMx8mRsdSz34qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748428710; c=relaxed/simple;
	bh=DSdyqohadKlnZ2salyc8skW3ausfpPqAXmOoA6KMWDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOjJGtX7KOdKXKPst46E1Y7NDgSz5z37L6YQtlrgpWuQmDSoMruq550ET3gZHo2J3fExmH/0SyEX8yhNfnd0O+syH6Vx1HqkeKe/bGS9HPvUy/kllbKNc3XpSJ3bV9c5l4SG0FM5YDWPAVUFqRdqMM1RAfMqvT6r4Vm9LkiESz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AqZQTN5V; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AqZQTN5V"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S5ZBQj007471;
	Wed, 28 May 2025 10:38:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=PtysNWj/u6cPOqrLbqPrybynvoAHDm
	rvn1jgdj6pirE=; b=AqZQTN5VGIUvwAvGZ4vsJvfKsCz81w/umGHdRDDbnpa/aV
	9Q2Wx/n+kbnY40RCWM7+GZgrx8YTdYQVAh9+6vHPvWvwFF4nL1spC3Bj2cl1K1Zv
	j4qO1fwV3mweTMYv1Ep8JOqAvVUXRrupUNqVJqxD2PKExPXs75lljionPcsFWwlq
	/53tyUnmzB3AB+8OeqSZ30xLOxpG1JEgDLCAxTxBeFFZaVW3WVNB0ryNsr6w49CY
	1gETBOdgg4d4GbwegQhJ+/ZtH/tQiQo5hHn2JZ0bYRZL1WEi9gCFN5TBCNwZd5mj
	IEpv/fz2ZXFULnc4kIhVvlhj+bgS417HWeFdwKSQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46wvfb1a31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 10:38:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54SAULmk021333;
	Wed, 28 May 2025 10:38:25 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46utnmpvqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 10:38:25 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54SAcL7R51577186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 10:38:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD4F720043;
	Wed, 28 May 2025 10:38:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A57CB20040;
	Wed, 28 May 2025 10:38:21 +0000 (GMT)
Received: from osiris (unknown [9.152.212.133])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 28 May 2025 10:38:21 +0000 (GMT)
Date: Wed, 28 May 2025 12:38:19 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: gor@linux.ibm.com, agordeev@linux.ibm.com, thuth@redhat.com,
        dengler@linux.ibm.com, linux-s390@vger.kernel.org
Subject: Re: [PATCH v4] s390/crypto: Select crypto engine in Kconfig when
 PAES is chosen
Message-ID: <20250528103819.10530C61-hca@linux.ibm.com>
References: <20250528083032.224430-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528083032.224430-1-freude@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDA5MiBTYWx0ZWRfX/5asXYKPFHWI jNGTX7acXeHmst+KWgDq5H5Ymg4ABpNnAD/uAtOnGAZJ5bq8wLaTOAyFFfkpIIAGve8mB9pBTfB XcFVB+H4Ls+Zuo8pjVsmgw5YrI9u3/OIUt4olbyhlPvPpSzK1SRExl7Pw7PalLahEEJonwTcB+6
 rj5AMOsd1bbbUR4vBMC85xoi5CcVM2WmZn7JHoa1z0+o9Lc/7c9GVA4J6j/Crl/i0SK+PY16dfx w2JbOXGkKZluzNuYlPB3C3BZ3QTJq/zY0Uag1LSIdl4UHLcN5r17tk3t2mHcKA3gyrCiWaEaKvB kXhcLjO/+rikHCKtR8ksIG7hx6sJ5QOvS0V+5nxz2ru0zuDx+/0kuveOQWWq7nWFXnFCDL3DYro
 4yIEV0Id2FM2uaNyebmg44iwQh2oD0uaY4ASj64oIktC39Lmy4iH/CmtZG1xD5Pp5RKhpO3K
X-Proofpoint-ORIG-GUID: n_HPmaKuG-thQ7ofepW46VJcpRuyMjFS
X-Authority-Analysis: v=2.4 cv=bt5MBFai c=1 sm=1 tr=0 ts=6836e7a2 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=gl1Mq3c7DWFSxH7cqnYA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: n_HPmaKuG-thQ7ofepW46VJcpRuyMjFS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_05,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=594
 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505280092

On Wed, May 28, 2025 at 10:30:32AM +0200, Harald Freudenberger wrote:
> The s390 PAES crypto algorithm has a dependency to the
> crypto engine. So enable the crypto engine via
> SELECT CRYPTO_ENGINE in drivers/crypto/Kconfig when
> CRYPTO_PAES_S390 is chosen.
> 
> Fixes: 6cd87cb5ef6c ("s390/crypto: Rework protected key AES for true asynch support")
> Reported-by: Thomas Huth <thuth@redhat.com>
> Closes: https://lore.kernel.org/linux-s390/f958f869-8da3-48d9-a118-f3cf9a9ea75c@redhat.com/
> Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>  drivers/crypto/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks!
