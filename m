From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] serial: forbid 8250 on s390
Date: Tue, 12 Dec 2017 18:50:47 +0100
Message-ID: <cc32ef2c-e940-cfd6-e2e7-f83d013951ea@de.ibm.com>
References: <20171212080835.23610-1-borntraeger@de.ibm.com>
 <20171212155032.2d5ece72@alans-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171212155032.2d5ece72@alans-desktop>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-serial/>
List-Post: <mailto:linux-serial@vger.kernel.org>
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 12/12/2017 04:50 PM, Alan Cox wrote:
> On Tue, 12 Dec 2017 09:08:35 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> Using "make kvmconfig" results in a potentially unusable linux image
>> on s390.  The reason is that both the (default on s390) sclp consoles
>> as well as the 8250 console register a ttyS<x> as console. Since there
>> will be no 8250 on s390 let's fence 8250. This will ensure that there
>> is always a working sclp console.
> 
> And there is no physical way to attach a PCI express UART to a 390 ?

There is (some sort of) PCI but these cards are packaged in ibm specific I/O cages.
So someone would need to apply some some serious hardware and firmware hacking (since
only IBM-approved PCi cards are allowed) and you would need to have an MSI-capable
8250 as well as an MSI capable driver. (we only support MSI, no classic interrupts)
In addition to that that 8250 probably needs to support virtual functions since we always
run with LPARs.
And even if we can solve all these issues I would say it really does not make any sense at
all, while the current situation obviously breaks the use case "make kvmconfig"

So unless IBM sees some serious business case for 8250, I am inclined to answer you
question with "no" :-)
