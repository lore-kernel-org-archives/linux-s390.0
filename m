Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: [PATCH v2] zcrypt: handle AP Info notification from CHSC SEI
 command
References: <1549488686-3746-1-git-send-email-akrowiak@linux.ibm.com>
 <alpine.LFD.2.21.1902071120580.7264@schleppi>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Thu, 7 Feb 2019 13:51:23 -0500
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.21.1902071120580.7264@schleppi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <9236bbef-fdba-ee7a-30d4-f94b1d81544a@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Sebastian Ott <sebott@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, freude@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, borntraeger@de.ibm.com, cohuck@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, akrowiak@linux.vnet.ibm.com, oberpar@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 2/7/19 5:24 AM, Sebastian Ott wrote:
> On Wed, 6 Feb 2019, Tony Krowiak wrote:
>> diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
>> +void ap_bus_cfg_chg(void)
>> +{
>> +	AP_DBF(DBF_INFO, "%s config change, forcing bus rescan\n", __func__);
>> +
>> +	ap_bus_force_rescan();
>> +}
>> +EXPORT_SYMBOL(ap_bus_cfg_chg);
> 
> There is still no need for the EXPORT_SYMBOL. You only call that function
> from chsc.c which is always build in.

I verified this, so I will take it out.

> 
