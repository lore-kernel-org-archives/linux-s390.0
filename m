From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: Re: [PATCH net-next V2 5/7] s390/qeth: improve endianness handling
Date: Tue, 11 Apr 2017 12:28:50 +0200
Message-ID: <509925af-3664-b9ff-7ae7-c668428b77cc@linux.vnet.ibm.com>
References: <20170407071538.63253-1-ubraun@linux.vnet.ibm.com>
 <20170407071538.63253-6-ubraun@linux.vnet.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6DCFFCAAFB@AcuExch.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DCFFCAAFB@AcuExch.aculab.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Laight <David.Laight@ACULAB.COM>, "davem@davemloft.net" <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "jwi@linux.vnet.ibm.com" <jwi@linux.vnet.ibm.com>, "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, "raspl@linux.vnet.ibm.com" <raspl@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 04/10/2017 05:16 PM, David Laight wrote:
> From: Ursula Braun
>> Sent: 07 April 2017 08:16
>> Avoid endianness warnings reported by sparse by (1) using endianness
>> conversions for assigning and using network packet fields, and (2)
>> removing unnecessary endianness conversions from qeth_l3_rebuild_skb. No
>> functional changes.
> ...
>> -	if (*p == ETH_P_8021Q)
>> +	if (be16_to_cpu(*p) == ETH_P_8021Q)
> ...
> 
> This is clearly different on little-endian systems.
> Also (probably) better written as:
> 
> 	if (*p == cpu_to_be16(ETH_P_8021Q))
> 
> so that the constant can by byteswapped.
> 
> 	David
> 

Thanks, we will keep that in mind for future patches.

> 
> 
