Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Mon, 10 Sep 2018 08:23:00 +0200
From: Benjamin Block <bblock@linux.ibm.com>
Subject: Re: [PATCH] s390: zfcp_aux: remove unnecessary null pointer check
 before mempool_destroy
References: <1536399705-21676-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1536399705-21676-1-git-send-email-zhongjiang@huawei.com>
Message-Id: <20180910062300.GA6465@w530-pk1mzal>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: zhong jiang <zhongjiang@huawei.com>
Cc: maier@linux.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sat, Sep 08, 2018 at 05:41:45PM +0800, zhong jiang wrote:
> mempool_destroy has taken null pointer check into account. so remove the
> redundant check.
>=20
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/s390/scsi/zfcp_aux.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/s390/scsi/zfcp_aux.c b/drivers/s390/scsi/zfcp_aux.c
> index 94f4d8f..e06c3f2 100644
> --- a/drivers/s390/scsi/zfcp_aux.c
> +++ b/drivers/s390/scsi/zfcp_aux.c
> @@ -248,20 +248,13 @@ static int zfcp_allocate_low_mem_buffers(struct zfc=
p_adapter *adapter)
> =20
>  static void zfcp_free_low_mem_buffers(struct zfcp_adapter *adapter)
>  {
> -	if (adapter->pool.erp_req)
> -		mempool_destroy(adapter->pool.erp_req);
> -	if (adapter->pool.scsi_req)
> -		mempool_destroy(adapter->pool.scsi_req);
> -	if (adapter->pool.scsi_abort)
> -		mempool_destroy(adapter->pool.scsi_abort);
> -	if (adapter->pool.qtcb_pool)
> -		mempool_destroy(adapter->pool.qtcb_pool);
> -	if (adapter->pool.status_read_req)
> -		mempool_destroy(adapter->pool.status_read_req);
> -	if (adapter->pool.sr_data)
> -		mempool_destroy(adapter->pool.sr_data);
> -	if (adapter->pool.gid_pn)
> -		mempool_destroy(adapter->pool.gid_pn);
> +	mempool_destroy(adapter->pool.erp_req);
> +	mempool_destroy(adapter->pool.scsi_req);
> +	mempool_destroy(adapter->pool.scsi_abort);
> +	mempool_destroy(adapter->pool.qtcb_pool);
> +	mempool_destroy(adapter->pool.status_read_req);
> +	mempool_destroy(adapter->pool.sr_data);
> +	mempool_destroy(adapter->pool.gid_pn);
>  }
> =20

Acked-by: Benjamin Block <bblock@linux.ibm.com>

Thank you. We'll send it along when we next send patches upstream.

--
With Best Regards, Benjamin Block      /      Linux on IBM Z Kernel Develop=
ment
IBM Systems & Technology Group   /  IBM Deutschland Research & Development =
GmbH
Vorsitz. AufsR.: Martina Koederitz       /      Gesch=E4ftsf=FChrung: Dirk =
Wittkopp
Sitz der Gesellschaft: B=F6blingen / Registergericht: AmtsG Stuttgart, HRB =
243294
