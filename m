MIME-Version: 1.0
In-Reply-To: <4F1066F8.4000602@mvista.com>
References: <1326470004-10096-1-git-send-email-akinobu.mita@gmail.com>
 <1326470004-10096-4-git-send-email-akinobu.mita@gmail.com>
 <4F1066F8.4000602@mvista.com>
Date: Sat, 14 Jan 2012 08:36:02 +0900
Message-ID: <CAC5umyiZd34q04r0M3MG3gw8_tFxQ8vxdB27ywiSDG+WjD8=Kg@mail.gmail.com>
Subject: Re: [PATCH 3/7] bitops: introduce list_for_each_clear_bit
From: Akinobu Mita <akinobu.mita@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linux-mtd/>
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, Robert Richter <robert.richter@amd.com>, x86@kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, linux-mtd@lists.infradead.org, "H. Peter Anvin" <hpa@zytor.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com, akpm@linux-foundation.org, David Woodhouse <dwmw2@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
List-ID: <linux-s390.vger.kernel.org>

2012/1/14 Sergei Shtylyov <sshtylyov@mvista.com>:
> Hello.
>
> On 01/13/2012 06:53 PM, Akinobu Mita wrote:
>
>> Introduce list_for_each_clear_bit() and list_for_each_clear_bit_from().
>
>
> =A0 It seems you've got somewhat muddled -- you're actually introducing
> for_each_clear_bit() and for_each_clear_bit_from()

Oops, thanks for a notification.
