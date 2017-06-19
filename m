From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH net-next 3/4] s390/diag: add diag26c support
Date: Mon, 19 Jun 2017 17:34:25 +0200
Message-ID: <20170619173425.4d537667@mschwideX1>
References: <20170619112225.30471-1-jwi@linux.vnet.ibm.com>
        <20170619112225.30471-4-jwi@linux.vnet.ibm.com>
        <20170619.104726.1778743929564587843.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170619.104726.1778743929564587843.davem@davemloft.net>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: jwi@linux.vnet.ibm.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

On Mon, 19 Jun 2017 10:47:26 -0400 (EDT)
David Miller <davem@davemloft.net> wrote:

> From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
> Date: Mon, 19 Jun 2017 13:22:24 +0200
> 
> > +#define DIAG26C_GET_MAC	0x0000
> > +struct diag26c_mac_req {
> > +	u32	resp_buf_len;
> > +	u32	resp_version;
> > +	u16	op_code;
> > +	u16	devno;
> > +	u8	res[4];
> > +} __packed;  
> 
> The packed attribute is not necessary here, the structure will be
> perfectly packed together because of the types used and the order of
> the members.

We (as in the s390 guys) tend to add __packed to hardware and hypervisor
structures even if the attribute is not strictly necessary. Most of the
diagnose related structures look that way. Dunno if it is worth to change
them.

I agree that __packed should be avoided for software defined structures.

> __packed is to be used only in the last possible resort for
> correctness and every effort whatsoever should be used to avoid using
> it.
> 
> > +
> > +struct diag26c_mac_resp {
> > +	u32	version;
> > +	u8	mac[ETH_ALEN];
> > +	u16	res;
> > +} __packed __aligned(8);  
> 
> Using packed with an 8 byte alignment is even more unnecessary.
> 
> Again, it is not needed, so please don't use it.

The diag26c struct needs to be aligned on a doubleword boundary, the
__aligned(8) is necessary. The __packed attribute is again superfluous but
follows along the lines of the other diag structures.

I do not mind the extra __packed attributes, but if you care about them
we could remove them from the structures in diag.h.

> > + */
> > +static inline int __diag26c(void *req, void *resp, enum diag26c_sc subcode)  
> 
> Do not mark functions inline in *.c files, let the compiler decide.
> 

Here I disagree. Basically all of our functions with assembly code are
static inline, it is a common pattern even in C files. Sometimes the compiler
*is* stupid and won't inline a function. And on s390 function calls do not
come for free.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
