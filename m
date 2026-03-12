Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCBA369982;
	Thu, 12 Mar 2026 19:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773344556; cv=none; b=NK6XZ2E9JeJ43ZVQKoIDRcjbHBc+VxLekKZmP4+VJiZPgsFN5lr7UX8P/vj3GJI+2nfMAg64G3dBN/6X/fzlmG1RN6AKZJHB0UAWxtKpWSsM/S1a5Fup438EsmIEjhdOji5sYn4fCdcqn2U8asx8YIMfmtnbF9Ny1Ruu9N985iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773344556; c=relaxed/simple;
	bh=rTdbe91PNWOuFZwhxiifMJT44PQUC9kCFWZ6GeSCR1Q=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=jfS7C30EA+GkmdSSz/rVCHrhqOxmQp2ppfZwTUnq9qE6A5Igd4hoCUBeE14udO5omDApOzUhFXgufwBBhjcoXPCRaKudfI/l/siH/VeQOvDjG0AdyO3OipVFEJ1MnLQSMW98c6SFIN/2fK7XgsQ6N+i7esB3wlg5AUuH4UGU040=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c1c2jo4H; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c1c2jo4H"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62CEJJ5N2581579;
	Thu, 12 Mar 2026 19:42:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LdrfMR
	YlxK9PjBAkdaN1q9+Uag/xN9Jirfj1RqwTqQE=; b=c1c2jo4HxLrMjlsD1JEJ14
	zkKBCa1fiRSp8MUlA3Clk8/8ssTP8S3vAg2Q0rjoBq5LGi/+227HX5o71SiSRJ+y
	dNRHumQao2v9cY08UTcZf+759KPxUZgltImZLKgzdlhd/XvbLZRyTGhG6qJPhYSI
	EJ+p14Flaq4OS/PzHAlzw2H4W99o56Sa74HwiQjpUM9bMjxhhUD2/IDjQQIkphTU
	oeU0aWfncizwIzNah+wtkyxoMpPUPCF1RRuR1yXCP2NCOXJ+j+i0qUlNBfmmRw/+
	EWYdTK4pcqKzT+U35XbT4TdVhQUzuZ2Fvw8mR2Iw+lD+XBlknSAsTUo0T14c9oaw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh94vm6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 19:42:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62CIQJL7006091;
	Thu, 12 Mar 2026 19:42:32 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha9kte5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 19:42:32 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62CJgVGo15270578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Mar 2026 19:42:31 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 091675805A;
	Thu, 12 Mar 2026 19:42:31 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 460AF5805D;
	Thu, 12 Mar 2026 19:42:27 +0000 (GMT)
Received: from [9.111.17.170] (unknown [9.111.17.170])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Mar 2026 19:42:27 +0000 (GMT)
Message-ID: <0536daedd01b7ad6f88719c9dc799a9de8a3bead.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/3] PCI: Move declaration of pci_rescan_remove_lock
 into public pci.h
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Benjamin Block <bblock@linux.ibm.com>,
        Alexander Gordeev	
 <agordeev@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Bjorn Helgaas	
 <bhelgaas@google.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens	
 <hca@linux.ibm.com>,
        "Ionut Nechita (Wind River)"
 <ionut.nechita@windriver.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger	
 <borntraeger@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        linux-pci	 <linux-pci@vger.kernel.org>,
        linux-kernel
 <linux-kernel@vger.kernel.org>,
        Ionut Nechita <ionut_n2001@yahoo.com>,
        Tobias Schumacher <ts@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        linux-s390
 <linux-s390@vger.kernel.org>,
        Julian Ruess	 <julianr@linux.ibm.com>,
        Ionut
 Nechita <ionut.nechita@windriver.com>,
        Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <e9f46b25e5b47ec1d8fdca33b10346bc6de23445.1773235561.git.bblock@linux.ibm.com>
References: <cover.1773235561.git.bblock@linux.ibm.com>
	 <e9f46b25e5b47ec1d8fdca33b10346bc6de23445.1773235561.git.bblock@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Mar 2026 20:41:26 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=QKtlhwLL c=1 sm=1 tr=0 ts=69b31729 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=VdXDybg-elbrzjsm0Y0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDE1OCBTYWx0ZWRfX/sZvbHv5dZWE
 0EEskF90oLm5KgIv4vz54ZC/Q32T97dcbUUmOfpv+yi3pGAZkWPLWvGEuuDJ61rAkOZTUmKhleW
 W0uTdm9PyzUi4Xjd9pZkmr/aoChmflLz89oFSX7qBOoItdkyTkrTE87qHY4vzRzk17dsQUd19PC
 pYzKyxTuJshDoZICXmE3fmqp8dYGjBpJ9MeAwwledkco6x7O+SHWp+k0w14BgiwAn5NBVOfQ/Cm
 31gVmmEKehV05YqOVx7lo8jp2V2aGldZdu/Ahq9Dmf2ixhmp+IXjniHQxu4fH4QhtfbAmdw1zr4
 dblxjm/DSkvnSLDAnJhewCIBLulcUFm86bF7582cmg6lpxMm3f4xQi0HwKxjz0i6cfHdHciYR/N
 VCcHMFncjPz5dFqyUcjDNbCme64f/TOWHm3SbONO+h6+RnFjM6pqLPwHT+zJOemrR7xIL6IbCsc
 p4cWc3s+qEg3/gYXluQ==
X-Proofpoint-ORIG-GUID: 3VJp8t3Bt38ZpA-QKO5ym6o1rJgZuX0S
X-Proofpoint-GUID: chpzErMu22y_tUO9KhXSd14i6O9mUA41
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_02,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603120158

On Wed, 2026-03-11 at 14:27 +0100, Benjamin Block wrote:
> So far it is possible to use and call the functions
> pci_lock_rescan_remove() and pci_unlock_rescan_remove() from any PCI
> code, including modules and architecture code; but the lock variable
> `pci_rescan_remove_lock` itself is private to objects residing in
> `drivers/pci/` via the header `drivers/pci/pci.h`.
>=20
> This makes it possible to use the lock - lock it, unlock it - from
> anywhere, but it is not possible to use lockdep annotations such as
> lockdep_assert_held(), or sparse annotations such as __must_hold() in
> modules or architecture code for PCI to make the usage more safe.
>=20
> Since it is useful for `pci_rescan_remove_lock` to have such
> annotations, move the variable declaration into `include/linux/pci.h`.
>=20
> Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
> ---
>  drivers/pci/pci.h   | 2 --
>  drivers/pci/probe.c | 1 +
>  include/linux/pci.h | 2 ++
>  3 files changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 13d998fbacce..6d611523420f 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -110,8 +110,6 @@ struct pcie_tlp_log;
>  extern const unsigned char pcie_link_speed[];
>  extern bool pci_early_dump;
> =20
> -extern struct mutex pci_rescan_remove_lock;
> -
>  bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
>  bool pcie_cap_has_lnkctl2(const struct pci_dev *dev);
>  bool pcie_cap_has_rtctl(const struct pci_dev *dev);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index bccc7a4bdd79..e5b12878e972 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -3509,6 +3509,7 @@ EXPORT_SYMBOL_GPL(pci_rescan_bus);
>   * routines should always be executed under this mutex.
>   */
>  DEFINE_MUTEX(pci_rescan_remove_lock);
> +EXPORT_SYMBOL_GPL(pci_rescan_remove_lock);

This has a (rather trivial) merge conflict with Ionut's patch which at
the same time is a prerequisite for this series. Sadly since that isn't
in linux-next yet I'm not sure how to best handle this. Maybe it would
make sense to just include it in this series? @Ionut would that be ok
for you?

> =20
>  void pci_lock_rescan_remove(void)
>  {
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 1c270f1d5123..fd7a962a64ef 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -39,6 +39,7 @@
>  #include <linux/io.h>
>  #include <linux/resource_ext.h>
>  #include <linux/msi_api.h>
> +#include <linux/mutex.h>
>  #include <uapi/linux/pci.h>
> =20
>  #include <linux/pci_ids.h>
> @@ -1533,6 +1534,7 @@ void set_pcie_hotplug_bridge(struct pci_dev *pdev);
> =20
>  /* Functions for PCI Hotplug drivers to use */
>  unsigned int pci_rescan_bus(struct pci_bus *bus);
> +extern struct mutex pci_rescan_remove_lock;
>  void pci_lock_rescan_remove(void);
>  void pci_unlock_rescan_remove(void);
> =20

I do see Keith's argument that proliferation of the rescan/remove lock
is to be minimized. That said, since user's of this header can already
lock/unlock I don't think this patch makes matters worse. In fact we
want this patch to be able to add better lockdep asserts so it will
help against misuse.

With that feel free to add:

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>

Thanks,
Niklas
