Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] s390: Replace zero-length array with flexible-array
 member
References: <20200221150612.GA9717@embeddedor>
 <your-ad-here.call-01582639032-ext-1911@work.hours>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <4a25a1a3-be56-e1b3-9c4f-fd902849d4bc@embeddedor.com>
Date: Tue, 25 Feb 2020 08:05:44 -0600
MIME-Version: 1.0
In-Reply-To: <your-ad-here.call-01582639032-ext-1911@work.hours>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org



On 2/25/20 07:57, Vasily Gorbik wrote:

>>
>> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
>> [2] https://github.com/KSPP/linux/issues/21
>> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>  arch/s390/appldata/appldata_os.c      | 2 +-
>>  drivers/s390/block/dasd_diag.c        | 2 +-
>>  drivers/s390/block/dasd_eckd.h        | 2 +-
>>  drivers/s390/char/raw3270.h           | 2 +-
>>  drivers/s390/char/sclp_pci.c          | 2 +-
>>  drivers/s390/cio/idset.c              | 2 +-
>>  drivers/s390/crypto/pkey_api.c        | 2 +-
>>  drivers/s390/crypto/zcrypt_ccamisc.h  | 2 +-
>>  drivers/s390/crypto/zcrypt_msgtype6.c | 2 +-
>>  9 files changed, 9 insertions(+), 9 deletions(-)
>>
> 
> Applied, thanks
> 

Thanks, Vasily.
--
Gustavo
