From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial: forbid 8250 on s390
Date: Tue, 12 Dec 2017 15:50:32 +0000
Message-ID: <20171212155032.2d5ece72@alans-desktop>
References: <20171212080835.23610-1-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171212080835.23610-1-borntraeger@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-serial/>
List-Post: <mailto:linux-serial@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 12 Dec 2017 09:08:35 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Using "make kvmconfig" results in a potentially unusable linux image
> on s390.  The reason is that both the (default on s390) sclp consoles
> as well as the 8250 console register a ttyS<x> as console. Since there
> will be no 8250 on s390 let's fence 8250. This will ensure that there
> is always a working sclp console.

And there is no physical way to attach a PCI express UART to a 390 ?

Alan
