Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21810 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732174AbgLNMwK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 14 Dec 2020 07:52:10 -0500
Date: Mon, 14 Dec 2020 13:49:52 +0100
From: Benjamin Block <bblock@linux.ibm.com>
Subject: Re: [PATCH v2] scsi: zfcp: move the position of put_device
Message-ID: <X9dfcBC/qqUc4bmh@t480-pf1aa2c2.linux.ibm.com>
References: <20201201024716.42926-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201201024716.42926-1-miaoqinglang@huawei.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Qinglang Miao <miaoqinglang@huawei.com>
Cc: Steffen Maier <maier@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 10:47:16AM +0800, Qinglang Miao wrote:
> Have the `put_device()` call after `device_unregister()` in both
> `zfcp_unit_remove()` and `zfcp_sysfs_port_remove_store()` to make
> it more natural, for put_device() ought to be the last time we
> touch the object in both functions.
>=20
> And add comments after put_device to make codes clearer.
>=20
> Suggested-by: Steffen Maier <maier@linux.ibm.com>
> Suggested-by: Benjamin Block <bblock@linux.ibm.com>
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>  v2: add comments after put_device as Steffen suggested.
>=20
>  drivers/s390/scsi/zfcp_sysfs.c | 4 ++--
>  drivers/s390/scsi/zfcp_unit.c  | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20

Got a bit delayed.
Looks good, I queue it, and we send it with the changes for 5.12 once
the merge window for 5.11 is over.

Thanks.

--=20
Best Regards, Benjamin Block  / Linux on IBM Z Kernel Development / IBM Sys=
tems
IBM Deutschland Research & Development GmbH    /    https://www.ibm.com/pri=
vacy
Vorsitz. AufsR.: Gregor Pillen         /        Gesch=EF=BF=BDftsf=EF=BF=BD=
hrung: Dirk Wittkopp
Sitz der Gesellschaft: B=EF=BF=BDblingen / Registergericht: AmtsG Stuttgart=
, HRB 243294
