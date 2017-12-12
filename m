From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] serial: forbid 8250 on s390
Date: Tue, 12 Dec 2017 09:56:05 +0100
Message-ID: <8e92cb31-f35a-6f4b-7409-035e87c0818a@de.ibm.com>
References: <20171212080835.23610-1-borntraeger@de.ibm.com>
 <20171212084808.GA14030@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171212084808.GA14030@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-serial/>
List-Post: <mailto:linux-serial@vger.kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 12/12/2017 09:48 AM, Greg Kroah-Hartman wrote:
> On Tue, Dec 12, 2017 at 09:08:35AM +0100, Christian Borntraeger wrote:
>> Using "make kvmconfig" results in a potentially unusable linux image
>> on s390.  The reason is that both the (default on s390) sclp consoles
>> as well as the 8250 console register a ttyS<x> as console. Since there
>> will be no 8250 on s390 let's fence 8250. This will ensure that there
>> is always a working sclp console.
>>
>> Reported-by: Alice Frosi <alice@linux.vnet.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
>> ---
>>  drivers/tty/serial/8250/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
> 
> Does this need to be backported to any stable kernels?  Or does anyone
> who runs them on s390 already have this config option disabled?

All shipped s390 kernels have 8250 disabled anyway. A backport of this
patch could be helpful to let users who want to use "make kvmconfig" give 
a working configuration but it is certainly not critical.

Christian
