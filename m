Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] s390/qeth: fix spelling mistake "alocpool" -> "allocpool"
References: <20190911153500.30836-1-colin.king@canonical.com>
 <de37e3a5-faad-44ae-32b2-d7c6c5d3732d@linux.ibm.com>
From: Colin Ian King <colin.king@canonical.com>
Message-ID: <e5b3aff1-9017-d169-1a8a-22a4d58efcb4@canonical.com>
Date: Thu, 12 Sep 2019 08:22:12 +0100
MIME-Version: 1.0
In-Reply-To: <de37e3a5-faad-44ae-32b2-d7c6c5d3732d@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Ursula Braun <ubraun@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: Julian Wiedmann <jwi@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>

On 12/09/2019 08:19, Ursula Braun wrote:
> 
> 
> On 9/11/19 5:35 PM, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> There is a spelling mistake in QETH_CARD_TEXT text. Fix it.
>>
> 
> This spelling mistake is intended, because this qeth trace area is defined for
> 8 byte length entries. We try to make the entries as speaking as possible - even
> at cost of spelling mistakes.

Ah, OK.

> 
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>>  drivers/s390/net/qeth_core_main.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
>> index a7868c8133ee..ab96b22db3fe 100644
>> --- a/drivers/s390/net/qeth_core_main.c
>> +++ b/drivers/s390/net/qeth_core_main.c
>> @@ -218,7 +218,7 @@ static int qeth_alloc_buffer_pool(struct qeth_card *card)
>>  	void *ptr;
>>  	int i, j;
>>  
>> -	QETH_CARD_TEXT(card, 5, "alocpool");
>> +	QETH_CARD_TEXT(card, 5, "allocpool");
>>  	for (i = 0; i < card->qdio.init_pool.buf_count; ++i) {
>>  		pool_entry = kzalloc(sizeof(*pool_entry), GFP_KERNEL);
>>  		if (!pool_entry) {
>>
> 
