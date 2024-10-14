Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4917D145346;
	Mon, 14 Oct 2024 06:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728888235; cv=none; b=tV4rRiYNYwiNafqejOWzb+Xg8VQYAPs/DViF+/UGk0MZJmibYRMcNjio03OGAau89rwcwJMaFeX0Y7KNHRybgp7VpxC8mZv6sac1NS5/JMJTFKenvEm5Nxdf0WbdeHBuMcWb5vZFrB2OA3n1gWWQY1fCVgyjCUWWzB0+ec9Gtvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728888235; c=relaxed/simple;
	bh=TSP39uxQ33k55GP7GMbXUy4I2HBra/Z6iszlVCQ3JFw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=reN4jNDJ+8SI/bLztW9LDdj2VWDLZctFeLuODH4fazxC1/UF3mwa+2bSZjX7pFEHMQF26fJppvziHhXJ4LtUfNlDrz42bq38Oy7Pdx1eexXzP54yQewfW3nKbYA847+xuO/YPXW12ZDEBc1o3tdBvx+J16KR5m6kzJ5gZ3+2DIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MhPmrXUd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MhPmrXUd"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49E4PN2Z011646;
	Mon, 14 Oct 2024 06:43:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	Njp3d2Pih9RuKZ/+voUKtRKyR3TRsxy4eGssHZ+t4dA=; b=MhPmrXUdJJd+mod2
	FvLDYVR/a0XNNdM+PUyxIFcUJlVYEqDG4zHghCtN1fsUY28oeO8ba0/+kBoMDBxb
	sbadfySfjwvdEee9XgU+FYgX2RvvZ5SEI2kAMF1ZPOI1shp/I/GdUC9+UG5x7IPk
	zw7k4a+ioFWDDGMMjIyPZHcbVoYqCJ2R2hoTqnPluk4yW1pAACurJhYd2l8Y01jM
	0JCt8xFUvb/iNtFlFQav8FS0efqmjK1vqDhv0Ug6mihQ38npbH9DN++BbBUhzZKj
	5zkKiLJtq8Kr4wxPp7rveMi3oVzcJ5HI4syNsV4FTt8pX5DPvpJXfINdXFYcQnKP
	ZUbfeg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 428v8crfhb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 06:43:43 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49E6hhWX018549;
	Mon, 14 Oct 2024 06:43:43 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 428v8crfh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 06:43:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49E4haN0005377;
	Mon, 14 Oct 2024 06:43:42 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4285nhvpq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 06:43:42 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49E6hdiH31588920
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 06:43:39 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E513220043;
	Mon, 14 Oct 2024 06:43:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40E0420040;
	Mon, 14 Oct 2024 06:43:38 +0000 (GMT)
Received: from [9.171.19.190] (unknown [9.171.19.190])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Oct 2024 06:43:38 +0000 (GMT)
Message-ID: <0ed7e21875ae766e751cafe9635f3fe49d4c933d.camel@linux.ibm.com>
Subject: Re: [PATCH] net/smc: fix wrong comparation in smc_pnet_add_pnetid
From: Gerd Bayer <gbayer@linux.ibm.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>,
        Li RongQing
 <lirongqing@baidu.com>, wenjia@linux.ibm.com,
        jaka@linux.ibm.com, tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, ubraun@linux.ibm.com, kgraul@linux.ibm.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org
Date: Mon, 14 Oct 2024 08:43:37 +0200
In-Reply-To: <39dfed0f-f7c8-47b8-8022-c4c2dc9a73dd@linux.alibaba.com>
References: <20241011061916.26310-1-lirongqing@baidu.com>
	 <39dfed0f-f7c8-47b8-8022-c4c2dc9a73dd@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 99dQdc6H51D_jyhfi2AuYPc-gATMf9d0
X-Proofpoint-ORIG-GUID: R8XSYVfB87ipRD8BKcwdiY5HDWI46jVy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_05,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 bulkscore=0 clxscore=1011 mlxscore=0
 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410140047

Hi Li RongQing,

On Mon, 2024-10-14 at 13:41 +0800, D. Wythe wrote:
> On 10/11/24 2:19 PM, Li RongQing wrote:
> > pnetid of pi (not newly allocated pe) should be compared
> >=20
> > Fixes: e888a2e8337c ("net/smc: introduce list of pnetids for
> > Ethernet devices")
> > Signed-off-by: Li RongQing <lirongqing@baidu.com>
> > ---
> > =C2=A0 net/smc/smc_pnet.c | 2 +-
> > =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
> > index 1dd3623..a04aa0e 100644
> > --- a/net/smc/smc_pnet.c
> > +++ b/net/smc/smc_pnet.c
> > @@ -753,7 +753,7 @@ static int smc_pnet_add_pnetid(struct net *net,
> > u8 *pnetid)
> > =C2=A0=20
> > =C2=A0=C2=A0	write_lock(&sn->pnetids_ndev.lock);
> > =C2=A0=C2=A0	list_for_each_entry(pi, &sn->pnetids_ndev.list, list) {
> > -		if (smc_pnet_match(pnetid, pe->pnetid)) {
> > +		if (smc_pnet_match(pnetid, pi->pnetid)) {
> > =C2=A0=C2=A0			refcount_inc(&pi->refcnt);
> > =C2=A0=C2=A0			kfree(pe);
> > =C2=A0=C2=A0			goto unlock;
>=20
> Reviewed-by: D. Wythe <alibuda@linux.alibaba.com>
>=20
> Thanks,
> D. Wythe
>=20

Good catch, indeed!

Is this intentionally discussed off-list?
For consideration by netdev maintainers this will have to be re-
submitted with a [PATCH net] prefix to the netdev mailing list.

Also, I'd prefer, if you could find a more descriptive subject. How
about: "Fix search in list of known pnetids"? However, if you want to
keep the subject please replace "comparation" with "comparison"

Thank you,
Gerd Bayer
