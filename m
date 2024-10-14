Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491CC13698E;
	Mon, 14 Oct 2024 07:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728890203; cv=none; b=WYRKRp/egQg67fLLPTxi1+yklq5GofIs3jPj0+UdmGcdo+U7wUPsO9Vuet0daNq8f+KlD5Ng5OIT0sdGaZwr1Y2SwfxM+BiYuUxQA54IvHDp6OfLUVVnGOQmCZV4TsSwXK5/pT57y59vfOwDlXOY7oCYKMJ3i+fYQhOHYydH3pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728890203; c=relaxed/simple;
	bh=63aZko8OKQY2ch1Sd6sepqwm20N9YFCHZ1HF0jCvECY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r3S86vyIjBTAPr7aJDc/fIDPCfQFm5NHXXQaUm4B/Dc/uI+n+0geJLNeVQj3qgeTzCfO/PVlnlyviVGARsDdFwioWyDZwdyFLKhnFcZQlgnRzLNkSWOgnQMXEmKAj55g8UEcVKJ5w0J+BhzHVZKqBXSwb2jZkrwfvKer2hVn/xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AF0fXnQX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AF0fXnQX"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49E6oTdW006068;
	Mon, 14 Oct 2024 07:16:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	bdYZBtThKi+yQ229McHYTwJj5wCOSUSh6GuZkvBp4ZI=; b=AF0fXnQXqccQx6J6
	p9f97wDLtN7fKxe2/z7N6dHrFLad3ulmbg0VENmys0kisKBhKSxb45ZswzdMe4on
	f/ADppJzvZ7gvYOsD7uG5ngSNIY8mcoEjaTVLkp21X1mxr8S48P9rm8YGbvhbcHz
	HlqbV/oH8JgX/eHSXsDJrkrwLAW7PF7jcGx77kNoXJEZs1d4aqs7cTFJC3QHOevA
	vxYZaFtPwsmw1+2/iuMpaT5qqzCiuo8mo5nvlN3kcploFXasuP2GDp/ElXAvK90h
	4pmmkYQyZGx+U3MbSnRIis6AFT9Xbx4l8J1MrUqvEaMtV6pnmiFF1NW+JMLkqlO+
	FS97BQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 428xchg515-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 07:16:35 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49E7D1VX021729;
	Mon, 14 Oct 2024 07:16:35 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 428xchg50t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 07:16:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49E4DsnD006761;
	Mon, 14 Oct 2024 07:16:33 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284xjw205-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 07:16:33 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49E7GTbj20971810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 07:16:29 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 686BD2004B;
	Mon, 14 Oct 2024 07:16:29 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BF8520040;
	Mon, 14 Oct 2024 07:16:26 +0000 (GMT)
Received: from [9.171.19.190] (unknown [9.171.19.190])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Oct 2024 07:16:26 +0000 (GMT)
Message-ID: <00837fae40c96ff1f598cf7383b7fa52152b9288.camel@linux.ibm.com>
Subject: Re: [PATCH] net/smc: fix wrong comparation in smc_pnet_add_pnetid
From: Gerd Bayer <gbayer@linux.ibm.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>,
        Li RongQing
 <lirongqing@baidu.com>, wenjia@linux.ibm.com,
        jaka@linux.ibm.com, tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, ubraun@linux.ibm.com, kgraul@linux.ibm.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org
Date: Mon, 14 Oct 2024 09:16:25 +0200
In-Reply-To: <0ed7e21875ae766e751cafe9635f3fe49d4c933d.camel@linux.ibm.com>
References: <20241011061916.26310-1-lirongqing@baidu.com>
	 <39dfed0f-f7c8-47b8-8022-c4c2dc9a73dd@linux.alibaba.com>
	 <0ed7e21875ae766e751cafe9635f3fe49d4c933d.camel@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: m4Nq7bTWTqDZ4F-0EGlY0RtSE91ndPCE
X-Proofpoint-GUID: NLqEm56Mb6C0_B9yfNPzZUYgoF0YPJSC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_06,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 phishscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410140051

On Mon, 2024-10-14 at 08:43 +0200, Gerd Bayer wrote:
> Hi Li RongQing,
>=20
> On Mon, 2024-10-14 at 13:41 +0800, D. Wythe wrote:
> > On 10/11/24 2:19 PM, Li RongQing wrote:
> > > pnetid of pi (not newly allocated pe) should be compared
> > >=20
> > > Fixes: e888a2e8337c ("net/smc: introduce list of pnetids for
> > > Ethernet devices")
> > > Signed-off-by: Li RongQing <lirongqing@baidu.com>
> > > ---
> > > =C2=A0 net/smc/smc_pnet.c | 2 +-
> > > =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
> > > index 1dd3623..a04aa0e 100644
> > > --- a/net/smc/smc_pnet.c
> > > +++ b/net/smc/smc_pnet.c
> > > @@ -753,7 +753,7 @@ static int smc_pnet_add_pnetid(struct net
> > > *net,
> > > u8 *pnetid)
> > > =C2=A0=20
> > > =C2=A0=C2=A0	write_lock(&sn->pnetids_ndev.lock);
> > > =C2=A0=C2=A0	list_for_each_entry(pi, &sn->pnetids_ndev.list, list) {
> > > -		if (smc_pnet_match(pnetid, pe->pnetid)) {
> > > +		if (smc_pnet_match(pnetid, pi->pnetid)) {
> > > =C2=A0=C2=A0			refcount_inc(&pi->refcnt);
> > > =C2=A0=C2=A0			kfree(pe);
> > > =C2=A0=C2=A0			goto unlock;
> >=20
> > Reviewed-by: D. Wythe <alibuda@linux.alibaba.com>
> >=20
> > Thanks,
> > D. Wythe
> >=20
>=20
> Good catch, indeed!
>=20
> Is this intentionally discussed off-list?
Oops - didn't read the entire To: list...

> For consideration by netdev maintainers this will have to be re-
> submitted with a [PATCH net] prefix to the netdev mailing list.
>=20
> Also, I'd prefer, if you could find a more descriptive subject. How
> about: "Fix search in list of known pnetids"? However, if you want to
> keep the subject please replace "comparation" with "comparison"
>=20
> Thank you,
> Gerd Bayer
>=20

