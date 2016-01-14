Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] SCSI-zfcp: Delete unnecessary checks before the function
 call "mempool_destroy"
References: <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net> <5649D8DE.1030809@users.sourceforge.net>
 <20151204175731.GA9185@bblock-ThinkPad-W530>
From: Steffen Maier <maier@linux.vnet.ibm.com>
Message-ID: <5697B705.9020700@linux.vnet.ibm.com>
Date: Thu, 14 Jan 2016 15:56:05 +0100
MIME-Version: 1.0
In-Reply-To: <20151204175731.GA9185@bblock-ThinkPad-W530>
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Benjamin Block <bblock@linux.vnet.ibm.com>, SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-ID: <linux-s390.vger.kernel.org>

Markus, thanks, I queued it for next time I send features upstream.
Don't hold your breath, fixes will go first.

Benjamin, thanks for the review.

Will add an informational comment that this depends on 4e3ca3e033d1=20
("mm/mempool: allow NULL `pool' pointer in mempool_destroy()").

On 12/04/2015 06:57 PM, Benjamin Block wrote:
> Hej Markus,
>
> On 14:23 Mon 16 Nov     , SF Markus Elfring wrote:
>> From: Markus Elfring <elfring@users.sourceforge.net>
>> Date: Mon, 16 Nov 2015 14:19:03 +0100
>>
>> The mempool_destroy() function tests whether its argument is NULL
>> and then returns immediately. Thus the test around the calls is not need=
ed.
>>
>> This issue was detected by using the Coccinelle software.
>>
>> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
>> ---
>>   drivers/s390/scsi/zfcp_aux.c | 21 +++++++--------------
>>   1 file changed, 7 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/s390/scsi/zfcp_aux.c b/drivers/s390/scsi/zfcp_aux.c
>> index c00ac46..abc9c93 100644
>> --- a/drivers/s390/scsi/zfcp_aux.c
>> +++ b/drivers/s390/scsi/zfcp_aux.c
>> @@ -248,20 +248,13 @@ static int zfcp_allocate_low_mem_buffers(struct zf=
cp_adapter *adapter)
>>
>>   static void zfcp_free_low_mem_buffers(struct zfcp_adapter *adapter)
>>   {
>> -	if (adapter->pool.erp_req)
>> -		mempool_destroy(adapter->pool.erp_req);
>> -	if (adapter->pool.scsi_req)
>> -		mempool_destroy(adapter->pool.scsi_req);
>> -	if (adapter->pool.scsi_abort)
>> -		mempool_destroy(adapter->pool.scsi_abort);
>> -	if (adapter->pool.qtcb_pool)
>> -		mempool_destroy(adapter->pool.qtcb_pool);
>> -	if (adapter->pool.status_read_req)
>> -		mempool_destroy(adapter->pool.status_read_req);
>> -	if (adapter->pool.sr_data)
>> -		mempool_destroy(adapter->pool.sr_data);
>> -	if (adapter->pool.gid_pn)
>> -		mempool_destroy(adapter->pool.gid_pn);
>> +	mempool_destroy(adapter->pool.erp_req);
>> +	mempool_destroy(adapter->pool.scsi_req);
>> +	mempool_destroy(adapter->pool.scsi_abort);
>> +	mempool_destroy(adapter->pool.qtcb_pool);
>> +	mempool_destroy(adapter->pool.status_read_req);
>> +	mempool_destroy(adapter->pool.sr_data);
>> +	mempool_destroy(adapter->pool.gid_pn);
>>   }
>>
>>   /**
>> --
>> 2.6.2
>
> Looks good to me, will have to wait though till Steffen is back around.
>
> Reviewed-by: Benjamin Block <bblock@linux.vnet.ibm.com>
>
>
>                                                      Beste Gr=FC=DFe / Be=
st regards,
>                                                        - Benjamin Block
>

--=20
Mit freundlichen Gr=FC=DFen / Kind regards
Steffen Maier

Linux on z Systems Development

IBM Deutschland Research & Development GmbH
Vorsitzende des Aufsichtsrats: Martina Koederitz
Geschaeftsfuehrung: Dirk Wittkopp
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
